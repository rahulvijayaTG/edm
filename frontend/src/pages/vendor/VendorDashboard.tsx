import React, { useEffect, useState } from 'react';
import { vendorApi } from '../../api/vendorApi';
import { VendorAnalytics } from '../../types';
import Loading from '../../components/common/Loading';

const VendorDashboard: React.FC = () => {
  const [analytics, setAnalytics] = useState<VendorAnalytics | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    vendorApi.getAnalytics()
      .then((res) => setAnalytics(res.data.data))
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  if (loading) return <Loading />;

  return (
    <div>
      <div className="page-header">
        <h1>Vendor Dashboard</h1>
      </div>
      <div className="stats-grid">
        <div className="stat-card">
          <div className="stat-value">{analytics?.totalProducts || 0}</div>
          <div className="stat-label">Total Products</div>
        </div>
        <div className="stat-card">
          <div className="stat-value">{analytics?.activeProducts || 0}</div>
          <div className="stat-label">Active Products</div>
        </div>
        <div className="stat-card">
          <div className="stat-value">{analytics?.totalOrders || 0}</div>
          <div className="stat-label">Total Orders</div>
        </div>
        <div className="stat-card">
          <div className="stat-value">{analytics?.pendingOrders || 0}</div>
          <div className="stat-label">Pending Orders</div>
        </div>
        <div className="stat-card">
          <div className="stat-value">${analytics?.totalRevenue?.toFixed(2) || '0.00'}</div>
          <div className="stat-label">Total Revenue</div>
        </div>
      </div>
    </div>
  );
};

export default VendorDashboard;
