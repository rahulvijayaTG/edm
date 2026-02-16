import api from './axios';
import { ApiResponse, Vendor, VendorAnalytics } from '../types';

export const vendorApi = {
  getActiveVendors: () =>
    api.get<ApiResponse<Vendor[]>>('/vendors/active'),

  getVendorById: (id: string) =>
    api.get<ApiResponse<Vendor>>(`/vendors/${id}`),

  getMyProfile: () =>
    api.get<ApiResponse<Vendor>>('/vendors/me/profile'),

  updateMyProfile: (data: Partial<Vendor>) =>
    api.put<ApiResponse<Vendor>>('/vendors/me/profile', data),

  getAnalytics: () =>
    api.get<ApiResponse<VendorAnalytics>>('/vendors/me/analytics'),

  // Admin
  getAllVendors: () =>
    api.get<ApiResponse<Vendor[]>>('/vendors'),

  toggleVendorStatus: (id: string) =>
    api.patch<ApiResponse<Vendor>>(`/vendors/${id}/toggle-status`),
};
