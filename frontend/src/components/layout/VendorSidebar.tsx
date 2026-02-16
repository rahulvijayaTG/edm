import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { useAppDispatch } from '../../hooks/useAppDispatch';
import { logout } from '../../store/slices/authSlice';

const VendorSidebar: React.FC = () => {
  const location = useLocation();
  const dispatch = useAppDispatch();

  const links = [
    { path: '/vendor', label: 'Dashboard' },
    { path: '/vendor/products', label: 'Products' },
    { path: '/vendor/orders', label: 'Orders' },
    { path: '/vendor/settings', label: 'Store Settings' },
  ];

  return (
    <div className="sidebar">
      <div className="sidebar-header">
        <h2>Vendor Panel</h2>
        <p>Manage your store</p>
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

export default VendorSidebar;
