import React from 'react';
import { Outlet } from 'react-router-dom';
import AdminSidebar from './AdminSidebar';
import VendorSidebar from './VendorSidebar';

interface Props {
  type: 'admin' | 'vendor';
}

const DashboardLayout: React.FC<Props> = ({ type }) => {
  return (
    <div className="app-layout">
      {type === 'admin' ? <AdminSidebar /> : <VendorSidebar />}
      <div className="main-content">
        <Outlet />
      </div>
    </div>
  );
};

export default DashboardLayout;
