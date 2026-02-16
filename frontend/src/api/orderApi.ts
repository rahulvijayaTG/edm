import api from './axios';
import { ApiResponse, Order } from '../types';

export const orderApi = {
  createOrder: (data: { items: { productId: string; quantity: number }[]; shippingAddress: string }) =>
    api.post<ApiResponse<Order[]>>('/orders', data),

  getMyOrders: () =>
    api.get<ApiResponse<Order[]>>('/orders/my'),

  getVendorOrders: () =>
    api.get<ApiResponse<Order[]>>('/orders/vendor'),

  updateOrderStatus: (id: string, status: string) =>
    api.patch<ApiResponse<Order>>(`/orders/${id}/status`, { status }),

  // Admin
  getAllOrders: () =>
    api.get<ApiResponse<Order[]>>('/orders'),
};
