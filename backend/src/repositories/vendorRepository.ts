import DataStore from '../models/DataStore';
import { Vendor } from '../types';

const store = DataStore.getInstance();

export const vendorRepository = {
  findAll(): Vendor[] {
    return Array.from(store.vendors.values());
  },

  findById(id: string): Vendor | undefined {
    return store.vendors.get(id);
  },

  findByUserId(userId: string): Vendor | undefined {
    return Array.from(store.vendors.values()).find((v) => v.userId === userId);
  },

  findActive(): Vendor[] {
    return Array.from(store.vendors.values()).filter((v) => v.isActive);
  },

  create(vendor: Vendor): Vendor {
    store.vendors.set(vendor.id, vendor);
    return vendor;
  },

  update(id: string, data: Partial<Vendor>): Vendor | undefined {
    const vendor = store.vendors.get(id);
    if (!vendor) return undefined;
    const updated = { ...vendor, ...data, updatedAt: new Date() };
    store.vendors.set(id, updated);
    return updated;
  },

  delete(id: string): boolean {
    return store.vendors.delete(id);
  },
};
