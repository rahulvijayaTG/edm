import { Request, Response, NextFunction } from 'express';
import { orderService } from '../services/orderService';
import { vendorService } from '../services/vendorService';
import { OrderStatus } from '../types';

export const orderController = {
  getAllOrders(_req: Request, res: Response, next: NextFunction) {
    try {
      const orders = orderService.getAllOrders();
      res.json({ success: true, data: orders });
    } catch (err) {
      next(err);
    }
  },

  getMyOrders(req: Request, res: Response, next: NextFunction) {
    try {
      const orders = orderService.getCustomerOrders(req.user!.userId);
      res.json({ success: true, data: orders });
    } catch (err) {
      next(err);
    }
  },

  getVendorOrders(req: Request, res: Response, next: NextFunction) {
    try {
      const vendor = vendorService.getVendorByUserId(req.user!.userId);
      const orders = orderService.getVendorOrders(vendor.id);
      res.json({ success: true, data: orders });
    } catch (err) {
      next(err);
    }
  },

  getOrderById(req: Request, res: Response, next: NextFunction) {
    try {
      const order = orderService.getOrderById(req.params.id);
      res.json({ success: true, data: order });
    } catch (err) {
      next(err);
    }
  },

  createOrder(req: Request, res: Response, next: NextFunction) {
    try {
      const { items, shippingAddress } = req.body;
      const orders = orderService.createOrder(req.user!.userId, items, shippingAddress);
      res.status(201).json({ success: true, data: orders });
    } catch (err) {
      next(err);
    }
  },

  updateOrderStatus(req: Request, res: Response, next: NextFunction) {
    try {
      const { status } = req.body;
      const order = orderService.updateOrderStatus(req.params.id, status as OrderStatus);
      res.json({ success: true, data: order });
    } catch (err) {
      next(err);
    }
  },
};
