import { Router } from 'express';
import authRoutes from './authRoutes';
import vendorRoutes from './vendorRoutes';
import productRoutes from './productRoutes';
import orderRoutes from './orderRoutes';
import adminRoutes from './adminRoutes';

const router = Router();

router.use('/auth', authRoutes);
router.use('/vendors', vendorRoutes);
router.use('/products', productRoutes);
router.use('/orders', orderRoutes);
router.use('/admin', adminRoutes);

export default router;
