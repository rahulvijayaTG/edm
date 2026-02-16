import api from './axios';
import { ApiResponse, AuthResponse, User } from '../types';

export const authApi = {
  register: (data: { email: string; password: string; name: string; role?: string }) =>
    api.post<ApiResponse<AuthResponse>>('/auth/register', data),

  login: (data: { email: string; password: string }) =>
    api.post<ApiResponse<AuthResponse>>('/auth/login', data),

  getProfile: () =>
    api.get<ApiResponse<User>>('/auth/profile'),
};
