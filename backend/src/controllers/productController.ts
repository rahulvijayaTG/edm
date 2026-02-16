import { Request, Response, NextFunction } from 'express';
import { productService } from '../services/productService';

export const productController = {
  getAllProducts(_req: Request, res: Response, next: NextFunction) {
    try {
      const products = productService.getAllProducts();
      res.json({ success: true, data: products });
    } catch (err) {
      next(err);
    }
  },

  getActiveProducts(_req: Request, res: Response, next: NextFunction) {
    try {
      const products = productService.getActiveProducts();
      res.json({ success: true, data: products });
    } catch (err) {
      next(err);
    }
  },

  getProductById(req: Request, res: Response, next: NextFunction) {
    try {
      const product = productService.getProductById(req.params.id);
      res.json({ success: true, data: product });
    } catch (err) {
      next(err);
    }
  },

  getProductsByVendor(req: Request, res: Response, next: NextFunction) {
    try {
      const products = productService.getProductsByVendorId(req.params.vendorId);
      res.json({ success: true, data: products });
    } catch (err) {
      next(err);
    }
  },

  getMyProducts(req: Request, res: Response, next: NextFunction) {
    try {
      const products = productService.getVendorProducts(req.user!.userId);
      res.json({ success: true, data: products });
    } catch (err) {
      next(err);
    }
  },

  createProduct(req: Request, res: Response, next: NextFunction) {
    try {
      const product = productService.createProduct(req.user!.userId, req.body);
      res.status(201).json({ success: true, data: product });
    } catch (err) {
      next(err);
    }
  },

  updateProduct(req: Request, res: Response, next: NextFunction) {
    try {
      const product = productService.updateProduct(req.user!.userId, req.params.id, req.body);
      res.json({ success: true, data: product });
    } catch (err) {
      next(err);
    }
  },

  deleteProduct(req: Request, res: Response, next: NextFunction) {
    try {
      productService.deleteProduct(req.user!.userId, req.params.id);
      res.json({ success: true, message: 'Product deleted successfully' });
    } catch (err) {
      next(err);
    }
  },

  uploadImages(req: Request, res: Response, next: NextFunction) {
    try {
      const files = req.files as Express.Multer.File[];
      const filenames = files?.map((f) => `/uploads/${f.filename}`) || [];
      const product = productService.uploadProductImages(req.user!.userId, req.params.id, filenames);
      res.json({ success: true, data: product });
    } catch (err) {
      next(err);
    }
  },
};
