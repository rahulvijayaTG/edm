import { v4 as uuidv4 } from 'uuid';
import { productRepository } from '../repositories/productRepository';
import { vendorRepository } from '../repositories/vendorRepository';
import { Product } from '../types';
import { ApiError } from '../utils/ApiError';

export const productService = {
  getAllProducts() {
    return productRepository.findAll();
  },

  getActiveProducts() {
    return productRepository.findActive();
  },

  getProductById(id: string) {
    const product = productRepository.findById(id);
    if (!product) throw ApiError.notFound('Product not found');
    return product;
  },

  getProductsByVendorId(vendorId: string) {
    return productRepository.findActiveByVendorId(vendorId);
  },

  getVendorProducts(userId: string) {
    const vendor = vendorRepository.findByUserId(userId);
    if (!vendor) throw ApiError.notFound('Vendor not found');
    return productRepository.findByVendorId(vendor.id);
  },

  createProduct(userId: string, data: Partial<Product>) {
    const vendor = vendorRepository.findByUserId(userId);
    if (!vendor) throw ApiError.notFound('Vendor profile not found');
    if (!vendor.isActive) throw ApiError.forbidden('Vendor account is deactivated');

    const product: Product = {
      id: uuidv4(),
      vendorId: vendor.id,
      name: data.name || '',
      description: data.description || '',
      price: data.price || 0,
      category: data.category || '',
      images: data.images || [],
      stock: data.stock || 0,
      isActive: data.isActive !== undefined ? data.isActive : true,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    return productRepository.create(product);
  },

  updateProduct(userId: string, productId: string, data: Partial<Product>) {
    const vendor = vendorRepository.findByUserId(userId);
    if (!vendor) throw ApiError.notFound('Vendor not found');

    const product = productRepository.findById(productId);
    if (!product) throw ApiError.notFound('Product not found');
    if (product.vendorId !== vendor.id) throw ApiError.forbidden('Not your product');

    return productRepository.update(productId, data);
  },

  deleteProduct(userId: string, productId: string) {
    const vendor = vendorRepository.findByUserId(userId);
    if (!vendor) throw ApiError.notFound('Vendor not found');

    const product = productRepository.findById(productId);
    if (!product) throw ApiError.notFound('Product not found');
    if (product.vendorId !== vendor.id) throw ApiError.forbidden('Not your product');

    return productRepository.delete(productId);
  },

  uploadProductImages(userId: string, productId: string, filenames: string[]) {
    const vendor = vendorRepository.findByUserId(userId);
    if (!vendor) throw ApiError.notFound('Vendor not found');

    const product = productRepository.findById(productId);
    if (!product) throw ApiError.notFound('Product not found');
    if (product.vendorId !== vendor.id) throw ApiError.forbidden('Not your product');

    const updatedImages = [...product.images, ...filenames];
    return productRepository.update(productId, { images: updatedImages });
  },
};
