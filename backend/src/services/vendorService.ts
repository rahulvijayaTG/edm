import { v4 as uuidv4 } from 'uuid';
import { vendorRepository } from '../repositories/vendorRepository';
import { productRepository } from '../repositories/productRepository';
import { orderRepository } from '../repositories/orderRepository';
import { Vendor } from '../types';
import { ApiError } from '../utils/ApiError';

export const vendorService = {
  getAllVendors() {
    return vendorRepository.findAll();
  },

  getActiveVendors() {
    return vendorRepository.findActive();
  },

  getVendorById(id: string) {
    const vendor = vendorRepository.findById(id);
    if (!vendor) throw ApiError.notFound('Vendor not found');
    return vendor;
  },

  getVendorByUserId(userId: string) {
    const vendor = vendorRepository.findByUserId(userId);
    if (!vendor) throw ApiError.notFound('Vendor profile not found');
    return vendor;
  },

  createVendorProfile(userId: string, data: Partial<Vendor>) {
    const existing = vendorRepository.findByUserId(userId);
    if (existing) throw ApiError.conflict('Vendor profile already exists');

    const vendor: Vendor = {
      id: uuidv4(),
      userId,
      storeName: data.storeName || 'My Store',
      description: data.description || '',
      logo: data.logo || '',
      theme: data.theme || 'default',
      isActive: true,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    return vendorRepository.create(vendor);
  },

  updateVendorProfile(userId: string, data: Partial<Vendor>) {
    const vendor = vendorRepository.findByUserId(userId);
    if (!vendor) throw ApiError.notFound('Vendor profile not found');
    return vendorRepository.update(vendor.id, data);
  },

  toggleVendorStatus(vendorId: string) {
    const vendor = vendorRepository.findById(vendorId);
    if (!vendor) throw ApiError.notFound('Vendor not found');
    return vendorRepository.update(vendorId, { isActive: !vendor.isActive });
  },

  getVendorAnalytics(userId: string) {
    const vendor = vendorRepository.findByUserId(userId);
    if (!vendor) throw ApiError.notFound('Vendor not found');

    const products = productRepository.findByVendorId(vendor.id);
    const orders = orderRepository.findByVendorId(vendor.id);
    const totalRevenue = orders.reduce((sum, o) => sum + o.totalAmount, 0);

    return {
      totalProducts: products.length,
      activeProducts: products.filter((p) => p.isActive).length,
      totalOrders: orders.length,
      totalRevenue,
      pendingOrders: orders.filter((o) => o.status === 'pending').length,
    };
  },
};
