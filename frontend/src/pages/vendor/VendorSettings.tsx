import React, { useEffect, useState } from 'react';
import { vendorApi } from '../../api/vendorApi';
import { Vendor } from '../../types';
import Loading from '../../components/common/Loading';

const VendorSettings: React.FC = () => {
  const [vendor, setVendor] = useState<Vendor | null>(null);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [message, setMessage] = useState('');

  useEffect(() => {
    vendorApi.getMyProfile()
      .then((res) => setVendor(res.data.data))
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  const handleSave = async () => {
    if (!vendor) return;
    setSaving(true);
    setMessage('');
    try {
      const res = await vendorApi.updateMyProfile({
        storeName: vendor.storeName,
        description: vendor.description,
        logo: vendor.logo,
        theme: vendor.theme,
      });
      setVendor(res.data.data);
      setMessage('Settings saved successfully!');
    } catch (err) {
      setMessage('Failed to save settings');
    }
    setSaving(false);
  };

  if (loading || !vendor) return <Loading />;

  return (
    <div>
      <div className="page-header">
        <h1>Store Settings</h1>
      </div>
      <div className="card" style={{ maxWidth: 600 }}>
        {message && (
          <div style={{
            background: message.includes('success') ? '#d4edda' : '#f8d7da',
            color: message.includes('success') ? '#155724' : '#721c24',
            padding: '10px 16px',
            borderRadius: 8,
            marginBottom: 16,
          }}>
            {message}
          </div>
        )}
        <div className="form-group">
          <label>Store Name</label>
          <input
            className="form-control"
            value={vendor.storeName}
            onChange={(e) => setVendor({ ...vendor, storeName: e.target.value })}
          />
        </div>
        <div className="form-group">
          <label>Description</label>
          <textarea
            className="form-control form-control-textarea"
            value={vendor.description}
            onChange={(e) => setVendor({ ...vendor, description: e.target.value })}
          />
        </div>
        <div className="form-group">
          <label>Logo URL</label>
          <input
            className="form-control"
            value={vendor.logo}
            onChange={(e) => setVendor({ ...vendor, logo: e.target.value })}
            placeholder="https://example.com/logo.png"
          />
        </div>
        <div className="form-group">
          <label>Theme</label>
          <select
            className="form-control"
            value={vendor.theme}
            onChange={(e) => setVendor({ ...vendor, theme: e.target.value })}
          >
            <option value="default">Default</option>
            <option value="blue">Blue</option>
            <option value="green">Green</option>
            <option value="pink">Pink</option>
            <option value="purple">Purple</option>
            <option value="dark">Dark</option>
          </select>
        </div>
        <button className="btn btn-primary" onClick={handleSave} disabled={saving}>
          {saving ? 'Saving...' : 'Save Settings'}
        </button>
      </div>
    </div>
  );
};

export default VendorSettings;
