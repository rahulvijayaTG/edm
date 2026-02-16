import api from './axios';
import { ApiResponse, DashboardStats, PlatformSettings } from '../types';

export const adminApi = {
  getDashboardStats: () =>
    api.get<ApiResponse<DashboardStats>>('/admin/dashboard'),

  getPlatformSettings: () =>
    api.get<ApiResponse<PlatformSettings>>('/admin/settings'),

  updatePlatformSettings: (data: Partial<PlatformSettings>) =>
    api.put<ApiResponse<PlatformSettings>>('/admin/settings', data),
};
