import DataStore from '../models/DataStore';
import { Product } from '../types';

const store = DataStore.getInstance();

export const productRepository = {
  findAll(): Product[] {
    return Array.from(store.products.values());
  },

  findById(id: string): Product | undefined {
    return store.products.get(id);
  },

  findByVendorId(vendorId: string): Product[] {
    return Array.from(store.products.values()).filter((p) => p.vendorId === vendorId);
  },

  findActiveByVendorId(vendorId: string): Product[] {
    return Array.from(store.products.values()).filter(
      (p) => p.vendorId === vendorId && p.isActive
    );
  },

  findActive(): Product[] {
    return Array.from(store.products.values()).filter((p) => p.isActive);
  },

  create(product: Product): Product {
    store.products.set(product.id, product);
    return product;
  },

  update(id: string, data: Partial<Product>): Product | undefined {
    const product = store.products.get(id);
    if (!product) return undefined;
    const updated = { ...product, ...data, updatedAt: new Date() };
    store.products.set(id, updated);
    return updated;
  },

  delete(id: string): boolean {
    return store.products.delete(id);
  },
};
