import { Router } from 'express';
import { productController } from '../controllers/productController';
import { authenticate, authorize } from '../middleware/auth';
import { validate } from '../middleware/validate';
import { productSchema, productUpdateSchema } from '../utils/validation';
import { upload } from '../middleware/upload';
import { Role } from '../types';

const router = Router();

// Public
router.get('/public', productController.getActiveProducts);
router.get('/public/:id', productController.getProductById);
router.get('/vendor/:vendorId', productController.getProductsByVendor);

// Vendor only
router.get('/my', authenticate, authorize(Role.VENDOR), productController.getMyProducts);
router.post('/', authenticate, authorize(Role.VENDOR), validate(productSchema), productController.createProduct);
router.put('/:id', authenticate, authorize(Role.VENDOR), validate(productUpdateSchema), productController.updateProduct);
router.delete('/:id', authenticate, authorize(Role.VENDOR), productController.deleteProduct);
router.post('/:id/images', authenticate, authorize(Role.VENDOR), upload.array('images', 5), productController.uploadImages);

// Admin
router.get('/', authenticate, authorize(Role.ADMIN), productController.getAllProducts);

export default router;
