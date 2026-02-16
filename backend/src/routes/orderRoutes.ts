import { Router } from 'express';
import { orderController } from '../controllers/orderController';
import { authenticate, authorize } from '../middleware/auth';
import { validate } from '../middleware/validate';
import { orderSchema, orderStatusSchema } from '../utils/validation';
import { Role } from '../types';

const router = Router();

// Customer
router.post('/', authenticate, authorize(Role.CUSTOMER), validate(orderSchema), orderController.createOrder);
router.get('/my', authenticate, authorize(Role.CUSTOMER), orderController.getMyOrders);

// Vendor
router.get('/vendor', authenticate, authorize(Role.VENDOR), orderController.getVendorOrders);
router.patch('/:id/status', authenticate, authorize(Role.VENDOR), validate(orderStatusSchema), orderController.updateOrderStatus);

// Admin
router.get('/', authenticate, authorize(Role.ADMIN), orderController.getAllOrders);
router.get('/:id', authenticate, orderController.getOrderById);

export default router;
