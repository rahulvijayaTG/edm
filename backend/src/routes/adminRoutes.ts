import { Router } from 'express';
import { adminController } from '../controllers/adminController';
import { authenticate, authorize } from '../middleware/auth';
import { validate } from '../middleware/validate';
import { platformSettingsSchema } from '../utils/validation';
import { Role } from '../types';

const router = Router();

router.use(authenticate, authorize(Role.ADMIN));

router.get('/dashboard', adminController.getDashboardStats);
router.get('/settings', adminController.getPlatformSettings);
router.put('/settings', validate(platformSettingsSchema), adminController.updatePlatformSettings);

export default router;
