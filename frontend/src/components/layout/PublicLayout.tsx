import React from 'react';
import { Outlet } from 'react-router-dom';
import PublicNavbar from './PublicNavbar';

const PublicLayout: React.FC = () => {
  return (
    <div className="public-layout">
      <PublicNavbar />
      <div className="public-content">
        <Outlet />
      </div>
    </div>
  );
};

export default PublicLayout;
