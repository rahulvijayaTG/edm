import DataStore from '../models/DataStore';
import { PlatformSettings } from '../types';
import { userRepository } from '../repositories/userRepository';

const store = DataStore.getInstance();

export const adminService = {
  getPlatformSettings(): PlatformSettings {
    return { ...store.platformSettings };
  },

  updatePlatformSettings(data: Partial<PlatformSettings>): PlatformSettings {
    store.platformSettings = { ...store.platformSettings, ...data };
    return store.platformSettings;
  },

  getDashboardStats() {
    const users = userRepository.findAll();
    return {
      totalUsers: users.length,
      totalVendors: store.vendors.size,
      activeVendors: Array.from(store.vendors.values()).filter((v) => v.isActive).length,
      totalProducts: store.products.size,
      totalOrders: store.orders.size,
      totalRevenue: Array.from(store.orders.values()).reduce((sum, o) => sum + o.totalAmount, 0),
    };
  },
};
