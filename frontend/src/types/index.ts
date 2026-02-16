export enum Role {
  ADMIN = 'admin',
  VENDOR = 'vendor',
  CUSTOMER = 'customer',
}

export interface User {
  id: string;
  email: string;
  name: string;
  role: Role;
  createdAt: string;
  updatedAt: string;
}

export interface Vendor {
  id: string;
  userId: string;
  storeName: string;
  description: string;
  logo: string;
  theme: string;
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
}

export interface Product {
  id: string;
  vendorId: string;
  name: string;
  description: string;
  price: number;
  category: string;
  images: string[];
  stock: number;
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
}

export interface OrderItem {
  productId: string;
  productName: string;
  quantity: number;
  price: number;
}

export interface Order {
  id: string;
  customerId: string;
  vendorId: string;
  items: OrderItem[];
  totalAmount: number;
  status: string;
  shippingAddress: string;
  createdAt: string;
  updatedAt: string;
}

export interface CartItem {
  product: Product;
  quantity: number;
}

export interface PlatformSettings {
  siteName: string;
  siteDescription: string;
  maintenanceMode: boolean;
  commissionRate: number;
}

export interface DashboardStats {
  totalUsers: number;
  totalVendors: number;
  activeVendors: number;
  totalProducts: number;
  totalOrders: number;
  totalRevenue: number;
}

export interface VendorAnalytics {
  totalProducts: number;
  activeProducts: number;
  totalOrders: number;
  totalRevenue: number;
  pendingOrders: number;
}

export interface ApiResponse<T> {
  success: boolean;
  data: T;
  message?: string;
  errors?: { field: string; message: string }[];
}

export interface AuthResponse {
  user: User;
  token: string;
}
