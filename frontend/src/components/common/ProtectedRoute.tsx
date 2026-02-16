import React from 'react';
import { Navigate } from 'react-router-dom';
import { useAppSelector } from '../../hooks/useAppDispatch';
import { Role } from '../../types';

interface Props {
  children: React.ReactNode;
  roles?: Role[];
}

const ProtectedRoute: React.FC<Props> = ({ children, roles }) => {
  const { user } = useAppSelector((state) => state.auth);

  if (!user) {
    return <Navigate to="/login" replace />;
  }

  if (roles && !roles.includes(user.role)) {
    return <Navigate to="/" replace />;
  }

  return <>{children}</>;
};

export default ProtectedRoute;
