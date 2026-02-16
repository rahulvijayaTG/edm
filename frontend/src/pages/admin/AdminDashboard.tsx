import React, { useEffect, useState } from 'react';
import { adminApi } from '../../api/adminApi';
import { DashboardStats } from '../../types';
import Loading from '../../components/common/Loading';

const AdminDashboard: React.FC = () => {
  const [stats, setStats] = useState<DashboardStats | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    adminApi.getDashboardStats()
      .then((res) => setStats(res.data.data))
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  if (loading) return <Loading />;

  return (
    <div>
      <div className="page-header">
        <h1>Admin Dashboard</h1>
      </div>
      <div className="stats-grid">
        <div className="stat-card">
          <div className="stat-value">{stats?.totalUsers || 0}</div>
          <div className="stat-label">Total Users</div>
        </div>
        <div className="stat-card">
          <div className="stat-value">{stats?.totalVendors || 0}</div>
          <div className="stat-label">Total Vendors</div>
        </div>
        <div className="stat-card">
          <div className="stat-value">{stats?.activeVendors || 0}</div>
          <div className="stat-label">Active Vendors</div>
        </div>
        <div className="stat-card">
          <div className="stat-value">{stats?.totalProducts || 0}</div>
          <div className="stat-label">Total Products</div>
        </div>
        <div className="stat-card">
          <div className="stat-value">{stats?.totalOrders || 0}</div>
          <div className="stat-label">Total Orders</div>
        </div>
        <div className="stat-card">
          <div className="stat-value">${stats?.totalRevenue?.toFixed(2) || '0.00'}</div>
          <div className="stat-label">Total Revenue</div>
        </div>
      </div>
    </div>
  );
};

export default AdminDashboard;
