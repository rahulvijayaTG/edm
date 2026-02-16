import { v4 as uuidv4 } from 'uuid';
import { orderRepository } from '../repositories/orderRepository';
import { productRepository } from '../repositories/productRepository';
import { Order, OrderItem, OrderStatus } from '../types';
import { ApiError } from '../utils/ApiError';

export const orderService = {
  getAllOrders() {
    return orderRepository.findAll();
  },

  getOrderById(id: string) {
    const order = orderRepository.findById(id);
    if (!order) throw ApiError.notFound('Order not found');
    return order;
  },

  getCustomerOrders(customerId: string) {
    return orderRepository.findByCustomerId(customerId);
  },

  getVendorOrders(vendorId: string) {
    return orderRepository.findByVendorId(vendorId);
  },

  createOrder(customerId: string, items: { productId: string; quantity: number }[], shippingAddress: string) {
    // Group items by vendor
    const vendorItemsMap = new Map<string, { product: any; quantity: number }[]>();

    for (const item of items) {
      const product = productRepository.findById(item.productId);
      if (!product) throw ApiError.notFound(`Product ${item.productId} not found`);
      if (!product.isActive) throw ApiError.badRequest(`Product ${product.name} is not available`);
      if (product.stock < item.quantity) {
        throw ApiError.badRequest(`Insufficient stock for ${product.name}`);
      }

      const existing = vendorItemsMap.get(product.vendorId) || [];
      existing.push({ product, quantity: item.quantity });
      vendorItemsMap.set(product.vendorId, existing);
    }

    const orders: Order[] = [];

    // Create one order per vendor
    for (const [vendorId, vendorItems] of vendorItemsMap) {
      const orderItems: OrderItem[] = vendorItems.map((vi) => ({
        productId: vi.product.id,
        productName: vi.product.name,
        quantity: vi.quantity,
        price: vi.product.price,
      }));

      const totalAmount = orderItems.reduce((sum, oi) => sum + oi.price * oi.quantity, 0);

      const order: Order = {
        id: uuidv4(),
        customerId,
        vendorId,
        items: orderItems,
        totalAmount,
        status: OrderStatus.PENDING,
        shippingAddress,
        createdAt: new Date(),
        updatedAt: new Date(),
      };

      orderRepository.create(order);
      orders.push(order);

      // Reduce stock
      for (const vi of vendorItems) {
        productRepository.update(vi.product.id, {
          stock: vi.product.stock - vi.quantity,
        });
      }
    }

    return orders;
  },

  updateOrderStatus(orderId: string, status: OrderStatus) {
    const order = orderRepository.findById(orderId);
    if (!order) throw ApiError.notFound('Order not found');
    return orderRepository.update(orderId, { status });
  },
};
