import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { vendorApi } from '../../api/vendorApi';
import { Vendor } from '../../types';
import Loading from '../../components/common/Loading';

const StoresPage: React.FC = () => {
  const [vendors, setVendors] = useState<Vendor[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    vendorApi.getActiveVendors()
      .then((res) => setVendors(res.data.data))
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  if (loading) return <Loading />;

  return (
    <div>
      <div className="page-header">
        <h1>All Stores</h1>
      </div>
      <div className="vendor-grid">
        {vendors.map((v) => (
          <Link to={`/store/${v.id}`} key={v.id}>
            <div className="vendor-card">
              <h3>{v.storeName}</h3>
              <p>{v.description || 'Visit this store to discover amazing products'}</p>
              <div style={{ marginTop: 12 }}>
                <span className="badge badge-info">{v.theme} theme</span>
              </div>
            </div>
          </Link>
        ))}
      </div>
      {vendors.length === 0 && (
        <div className="empty-state">
          <div className="icon">&#127978;</div>
          <h3>No stores available yet</h3>
          <p>Check back soon!</p>
        </div>
      )}
    </div>
  );
};

export default StoresPage;
