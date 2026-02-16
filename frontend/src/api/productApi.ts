import api from './axios';
import { ApiResponse, Product } from '../types';

export const productApi = {
  getActiveProducts: () =>
    api.get<ApiResponse<Product[]>>('/products/public'),

  getProductById: (id: string) =>
    api.get<ApiResponse<Product>>(`/products/public/${id}`),

  getProductsByVendor: (vendorId: string) =>
    api.get<ApiResponse<Product[]>>(`/products/vendor/${vendorId}`),

  // Vendor
  getMyProducts: () =>
    api.get<ApiResponse<Product[]>>('/products/my'),

  createProduct: (data: Partial<Product>) =>
    api.post<ApiResponse<Product>>('/products', data),

  updateProduct: (id: string, data: Partial<Product>) =>
    api.put<ApiResponse<Product>>(`/products/${id}`, data),

  deleteProduct: (id: string) =>
    api.delete<ApiResponse<void>>(`/products/${id}`),

  uploadImages: (id: string, formData: FormData) =>
    api.post<ApiResponse<Product>>(`/products/${id}/images`, formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    }),

  // Admin
  getAllProducts: () =>
    api.get<ApiResponse<Product[]>>('/products'),
};
