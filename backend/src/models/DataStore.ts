import { User, Vendor, Product, Order, PlatformSettings } from '../types';

class DataStore {
  private static instance: DataStore;

  users: Map<string, User> = new Map();
  vendors: Map<string, Vendor> = new Map();
  products: Map<string, Product> = new Map();
  orders: Map<string, Order> = new Map();
  platformSettings: PlatformSettings = {
    siteName: 'EDM Marketplace',
    siteDescription: 'A multi-vendor e-commerce marketplace',
    maintenanceMode: false,
    commissionRate: 10,
  };

  private constructor() {}

  static getInstance(): DataStore {
    if (!DataStore.instance) {
      DataStore.instance = new DataStore();
    }
    return DataStore.instance;
  }

  reset(): void {
    this.users.clear();
    this.vendors.clear();
    this.products.clear();
    this.orders.clear();
  }
}

export default DataStore;
