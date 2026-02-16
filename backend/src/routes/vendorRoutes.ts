import { Router } from 'express';
import { vendorController } from '../controllers/vendorController';
import { authenticate, authorize } from '../middleware/auth';
import { validate } from '../middleware/validate';
import { vendorProfileSchema } from '../utils/validation';
import { Role } from '../types';

const router = Router();

// Public
router.get('/active', vendorController.getActiveVendors);
router.get('/:id', vendorController.getVendorById);

// Vendor only
router.get('/me/profile', authenticate, authorize(Role.VENDOR), vendorController.getMyProfile);
router.put('/me/profile', authenticate, authorize(Role.VENDOR), validate(vendorProfileSchema), vendorController.updateMyProfile);
router.get('/me/analytics', authenticate, authorize(Role.VENDOR), vendorController.getAnalytics);

// Admin only
router.get('/', authenticate, authorize(Role.ADMIN), vendorController.getAllVendors);
router.patch('/:id/toggle-status', authenticate, authorize(Role.ADMIN), vendorController.toggleVendorStatus);

export default router;
