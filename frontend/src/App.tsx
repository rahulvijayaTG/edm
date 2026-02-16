import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import './App.css';

// Layouts
import PublicLayout from './components/layout/PublicLayout';
import DashboardLayout from './components/layout/DashboardLayout';
import ProtectedRoute from './components/common/ProtectedRoute';
import { Role } from './types';

// Auth Pages
import LoginPage from './pages/auth/LoginPage';
import RegisterPage from './pages/auth/RegisterPage';

// Public Store Pages
import HomePage from './pages/store/HomePage';
import StoresPage from './pages/store/StoresPage';
import VendorStorePage from './pages/store/VendorStorePage';
import ProductDetailPage from './pages/store/ProductDetailPage';
import CartPage from './pages/store/CartPage';
import MyOrdersPage from './pages/store/MyOrdersPage';

// Admin Pages
import AdminDashboard from './pages/admin/AdminDashboard';
import AdminVendors from './pages/admin/AdminVendors';
import AdminProducts from './pages/admin/AdminProducts';
import AdminOrders from './pages/admin/AdminOrders';
import AdminSettings from './pages/admin/AdminSettings';

// Vendor Pages
import VendorDashboard from './pages/vendor/VendorDashboard';
import VendorProducts from './pages/vendor/VendorProducts';
import VendorOrders from './pages/vendor/VendorOrders';
import VendorSettings from './pages/vendor/VendorSettings';

function App() {
  return (
    <Router>
      <Routes>
        {/* Auth Routes */}
        <Route path="/login" element={<LoginPage />} />
        <Route path="/register" element={<RegisterPage />} />

        {/* Public Store Routes */}
        <Route element={<PublicLayout />}>
          <Route path="/" element={<HomePage />} />
          <Route path="/stores" element={<StoresPage />} />
          <Route path="/store/:vendorId" element={<VendorStorePage />} />
          <Route path="/product/:id" element={<ProductDetailPage />} />
          <Route path="/cart" element={<CartPage />} />
          <Route path="/my-orders" element={
            <ProtectedRoute roles={[Role.CUSTOMER]}>
              <MyOrdersPage />
            </ProtectedRoute>
          } />
        </Route>

        {/* Admin Routes */}
        <Route element={
          <ProtectedRoute roles={[Role.ADMIN]}>
            <DashboardLayout type="admin" />
          </ProtectedRoute>
        }>
          <Route path="/admin" element={<AdminDashboard />} />
          <Route path="/admin/vendors" element={<AdminVendors />} />
          <Route path="/admin/products" element={<AdminProducts />} />
          <Route path="/admin/orders" element={<AdminOrders />} />
          <Route path="/admin/settings" element={<AdminSettings />} />
        </Route>

        {/* Vendor Routes */}
        <Route element={
          <ProtectedRoute roles={[Role.VENDOR]}>
            <DashboardLayout type="vendor" />
          </ProtectedRoute>
        }>
          <Route path="/vendor" element={<VendorDashboard />} />
          <Route path="/vendor/products" element={<VendorProducts />} />
          <Route path="/vendor/orders" element={<VendorOrders />} />
          <Route path="/vendor/settings" element={<VendorSettings />} />
        </Route>
      </Routes>
    </Router>
  );
}

export default App;
