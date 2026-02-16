import React, { useEffect, useState } from 'react';
import { adminApi } from '../../api/adminApi';
import { PlatformSettings } from '../../types';
import Loading from '../../components/common/Loading';

const AdminSettings: React.FC = () => {
  const [settings, setSettings] = useState<PlatformSettings | null>(null);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [message, setMessage] = useState('');

  useEffect(() => {
    adminApi.getPlatformSettings()
      .then((res) => setSettings(res.data.data))
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  const handleSave = async () => {
    if (!settings) return;
    setSaving(true);
    setMessage('');
    try {
      const res = await adminApi.updatePlatformSettings(settings);
      setSettings(res.data.data);
      setMessage('Settings saved successfully!');
    } catch (err) {
      setMessage('Failed to save settings');
    }
    setSaving(false);
  };

  if (loading || !settings) return <Loading />;

  return (
    <div>
      <div className="page-header">
        <h1>Platform Settings</h1>
      </div>
      <div className="card" style={{ maxWidth: 600 }}>
        {message && (
          <div className={message.includes('success') ? 'badge badge-success' : 'error-message'} style={{marginBottom: 16, padding: '10px 16px'}}>
            {message}
          </div>
        )}
        <div className="form-group">
          <label>Site Name</label>
          <input
            className="form-control"
            value={settings.siteName}
            onChange={(e) => setSettings({ ...settings, siteName: e.target.value })}
          />
        </div>
        <div className="form-group">
          <label>Site Description</label>
          <textarea
            className="form-control form-control-textarea"
            value={settings.siteDescription}
            onChange={(e) => setSettings({ ...settings, siteDescription: e.target.value })}
          />
        </div>
        <div className="form-group">
          <label>Commission Rate (%)</label>
          <input
            type="number"
            className="form-control"
            value={settings.commissionRate}
            onChange={(e) => setSettings({ ...settings, commissionRate: parseFloat(e.target.value) || 0 })}
            min={0}
            max={100}
          />
        </div>
        <div className="form-group">
          <label style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
            <input
              type="checkbox"
              checked={settings.maintenanceMode}
              onChange={(e) => setSettings({ ...settings, maintenanceMode: e.target.checked })}
            />
            Maintenance Mode
          </label>
        </div>
        <button className="btn btn-primary" onClick={handleSave} disabled={saving}>
          {saving ? 'Saving...' : 'Save Settings'}
        </button>
      </div>
    </div>
  );
};

export default AdminSettings;
