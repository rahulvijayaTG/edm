import React, { useEffect, useState } from 'react';
import { vendorApi } from '../../api/vendorApi';
import { Vendor } from '../../types';
import Loading from '../../components/common/Loading';

const AdminVendors: React.FC = () => {
  const [vendors, setVendors] = useState<Vendor[]>([]);
  const [loading, setLoading] = useState(true);

  const fetchVendors = () => {
    setLoading(true);
    vendorApi.getAllVendors()
      .then((res) => setVendors(res.data.data))
      .catch(console.error)
      .finally(() => setLoading(false));
  };

  useEffect(() => { fetchVendors(); }, []);

  const handleToggle = async (id: string) => {
    try {
      await vendorApi.toggleVendorStatus(id);
      fetchVendors();
    } catch (err) {
      console.error(err);
    }
  };

  if (loading) return <Loading />;

  return (
    <div>
      <div className="page-header">
        <h1>Manage Vendors</h1>
      </div>
      <div className="card">
        <div className="table-container">
          <table>
            <thead>
              <tr>
                <th>Store Name</th>
                <th>Description</th>
                <th>Theme</th>
                <th>Status</th>
                <th>Created</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {vendors.map((v) => (
                <tr key={v.id}>
                  <td><strong>{v.storeName}</strong></td>
                  <td>{v.description || '-'}</td>
                  <td>{v.theme}</td>
                  <td>
                    <span className={`badge ${v.isActive ? 'badge-success' : 'badge-danger'}`}>
                      {v.isActive ? 'Active' : 'Inactive'}
                    </span>
                  </td>
                  <td>{new Date(v.createdAt).toLocaleDateString()}</td>
                  <td>
                    <button
                      className={`btn btn-sm ${v.isActive ? 'btn-danger' : 'btn-success'}`}
                      onClick={() => handleToggle(v.id)}
                    >
                      {v.isActive ? 'Deactivate' : 'Activate'}
                    </button>
                  </td>
                </tr>
              ))}
              {vendors.length === 0 && (
                <tr><td colSpan={6} style={{textAlign: 'center', padding: '40px'}}>No vendors found</td></tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default AdminVendors;
