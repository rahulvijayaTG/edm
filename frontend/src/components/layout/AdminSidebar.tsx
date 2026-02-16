import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { useAppDispatch } from '../../hooks/useAppDispatch';
import { logout } from '../../store/slices/authSlice';

const AdminSidebar: React.FC = () => {
  const location = useLocation();
  const dispatch = useAppDispatch();

  const links = [
    { path: '/admin', label: 'Dashboard' },
    { path: '/admin/vendors', label: 'Vendors' },
    { path: '/admin/products', label: 'Products' },
    { path: '/admin/orders', label: 'Orders' },
    { path: '/admin/settings', label: 'Settings' },
  ];

  return (
    <div className="sidebar">
      <div className="sidebar-header">
        <h2>Admin Panel</h2>
        <p>EDM Marketplace</p>
      </div>
      <ul className="sidebar-nav">
        {links.map((link) => (
          <li key={link.path}>
            <Link to={link.path} className={location.pathname === link.path ? 'active' : ''}>
              {link.label}
            </Link>
          </li>
        ))}
        <li><Link to="/">Back to Store</Link></li>
        <li><button onClick={() => dispatch(logout())}>Logout</button></li>
      </ul>
    </div>
  );
};

export default AdminSidebar;
