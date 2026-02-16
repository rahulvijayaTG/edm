import React from 'react';
import { Link } from 'react-router-dom';
import { useAppSelector, useAppDispatch } from '../../hooks/useAppDispatch';
import { logout } from '../../store/slices/authSlice';
import { Role } from '../../types';

const PublicNavbar: React.FC = () => {
  const { user } = useAppSelector((state) => state.auth);
  const { items } = useAppSelector((state) => state.cart);
  const dispatch = useAppDispatch();

  const cartCount = items.reduce((sum, i) => sum + i.quantity, 0);

  return (
    <nav className="navbar">
      <Link to="/" className="navbar-brand">EDM Marketplace</Link>
      <ul className="navbar-links">
        <li><Link to="/">Home</Link></li>
        <li><Link to="/stores">Stores</Link></li>
        <li className="cart-badge">
          <Link to="/cart">Cart {cartCount > 0 && <span className="cart-count">{cartCount}</span>}</Link>
        </li>
        {user ? (
          <>
            {user.role === Role.ADMIN && <li><Link to="/admin">Admin Panel</Link></li>}
            {user.role === Role.VENDOR && <li><Link to="/vendor">Dashboard</Link></li>}
            {user.role === Role.CUSTOMER && <li><Link to="/my-orders">My Orders</Link></li>}
            <li><span style={{color: '#777'}}>Hi, {user.name}</span></li>
            <li><button className="btn btn-sm btn-outline" onClick={() => dispatch(logout())}>Logout</button></li>
          </>
        ) : (
          <>
            <li><Link to="/login">Login</Link></li>
            <li><Link to="/register" className="btn btn-sm btn-primary">Register</Link></li>
          </>
        )}
      </ul>
    </nav>
  );
};

export default PublicNavbar;
