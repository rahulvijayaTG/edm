import { z } from 'zod';

export const registerSchema = z.object({
  email: z.string().email('Invalid email address'),
  password: z.string().min(6, 'Password must be at least 6 characters'),
  name: z.string().min(2, 'Name must be at least 2 characters'),
  role: z.enum(['vendor', 'customer']).optional().default('customer'),
});

export const loginSchema = z.object({
  email: z.string().email('Invalid email address'),
  password: z.string().min(1, 'Password is required'),
});

export const vendorProfileSchema = z.object({
  storeName: z.string().min(2, 'Store name must be at least 2 characters'),
  description: z.string().optional().default(''),
  logo: z.string().optional().default(''),
  theme: z.string().optional().default('default'),
});

export const productSchema = z.object({
  name: z.string().min(2, 'Product name must be at least 2 characters'),
  description: z.string().min(10, 'Description must be at least 10 characters'),
  price: z.number().positive('Price must be positive'),
  category: z.string().min(2, 'Category is required'),
  stock: z.number().int().min(0, 'Stock cannot be negative'),
  images: z.array(z.string()).optional().default([]),
  isActive: z.boolean().optional().default(true),
});

export const productUpdateSchema = productSchema.partial();

export const orderSchema = z.object({
  items: z
    .array(
      z.object({
        productId: z.string().uuid(),
        quantity: z.number().int().positive(),
      })
    )
    .min(1, 'Order must have at least one item'),
  shippingAddress: z.string().min(10, 'Shipping address is required'),
});

export const orderStatusSchema = z.object({
  status: z.enum(['pending', 'confirmed', 'shipped', 'delivered', 'cancelled']),
});

export const platformSettingsSchema = z.object({
  siteName: z.string().optional(),
  siteDescription: z.string().optional(),
  maintenanceMode: z.boolean().optional(),
  commissionRate: z.number().min(0).max(100).optional(),
});
