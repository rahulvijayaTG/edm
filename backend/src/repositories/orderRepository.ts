import DataStore from '../models/DataStore';
import { Order } from '../types';

const store = DataStore.getInstance();

export const orderRepository = {
  findAll(): Order[] {
    return Array.from(store.orders.values());
  },

  findById(id: string): Order | undefined {
    return store.orders.get(id);
  },

  findByCustomerId(customerId: string): Order[] {
    return Array.from(store.orders.values()).filter((o) => o.customerId === customerId);
  },

  findByVendorId(vendorId: string): Order[] {
    return Array.from(store.orders.values()).filter((o) => o.vendorId === vendorId);
  },

  create(order: Order): Order {
    store.orders.set(order.id, order);
    return order;
  },

  update(id: string, data: Partial<Order>): Order | undefined {
    const order = store.orders.get(id);
    if (!order) return undefined;
    const updated = { ...order, ...data, updatedAt: new Date() };
    store.orders.set(id, updated);
    return updated;
  },
};
