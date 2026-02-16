import bcrypt from 'bcryptjs';
import { v4 as uuidv4 } from 'uuid';
import DataStore from './models/DataStore';
import { Role, OrderStatus } from './types';

async function seed() {
  const store = DataStore.getInstance();
  store.reset();

  console.log('Seeding data...');

  // Create admin
  const adminId = uuidv4();
  store.users.set(adminId, {
    id: adminId,
    email: 'admin@edm.com',
    password: await bcrypt.hash('admin123', 10),
    name: 'Platform Admin',
    role: Role.ADMIN,
    createdAt: new Date(),
    updatedAt: new Date(),
  });

  // Create vendors
  const vendor1UserId = uuidv4();
  const vendor1Id = uuidv4();
  store.users.set(vendor1UserId, {
    id: vendor1UserId,
    email: 'vendor1@edm.com',
    password: await bcrypt.hash('vendor123', 10),
    name: 'John Electronics',
    role: Role.VENDOR,
    createdAt: new Date(),
    updatedAt: new Date(),
  });
  store.vendors.set(vendor1Id, {
    id: vendor1Id,
    userId: vendor1UserId,
    storeName: 'John\'s Electronics',
    description: 'Best electronics at affordable prices',
    logo: '',
    theme: 'blue',
    isActive: true,
    createdAt: new Date(),
    updatedAt: new Date(),
  });

  const vendor2UserId = uuidv4();
  const vendor2Id = uuidv4();
  store.users.set(vendor2UserId, {
    id: vendor2UserId,
    email: 'vendor2@edm.com',
    password: await bcrypt.hash('vendor123', 10),
    name: 'Sarah Fashion',
    role: Role.VENDOR,
    createdAt: new Date(),
    updatedAt: new Date(),
  });
  store.vendors.set(vendor2Id, {
    id: vendor2Id,
    userId: vendor2UserId,
    storeName: 'Sarah\'s Fashion Hub',
    description: 'Trendy fashion for everyone',
    logo: '',
    theme: 'pink',
    isActive: true,
    createdAt: new Date(),
    updatedAt: new Date(),
  });

  // Create products for vendor 1
  const products1 = [
    { name: 'Wireless Headphones', description: 'High quality wireless headphones with noise cancellation', price: 79.99, category: 'Electronics', stock: 50 },
    { name: 'Smartphone Stand', description: 'Adjustable aluminum smartphone stand for desk use', price: 24.99, category: 'Accessories', stock: 100 },
    { name: 'USB-C Hub', description: 'Multi-port USB-C hub with HDMI, USB 3.0, and SD card reader', price: 49.99, category: 'Electronics', stock: 30 },
    { name: 'Bluetooth Speaker', description: 'Portable bluetooth speaker with 20 hour battery life', price: 39.99, category: 'Electronics', stock: 75 },
  ];

  for (const p of products1) {
    const id = uuidv4();
    store.products.set(id, {
      id,
      vendorId: vendor1Id,
      ...p,
      images: [],
      isActive: true,
      createdAt: new Date(),
      updatedAt: new Date(),
    });
  }

  // Create products for vendor 2
  const products2 = [
    { name: 'Summer Dress', description: 'Beautiful floral summer dress in multiple sizes and colors', price: 45.99, category: 'Clothing', stock: 40 },
    { name: 'Leather Wallet', description: 'Genuine leather bifold wallet with RFID protection', price: 29.99, category: 'Accessories', stock: 60 },
    { name: 'Sunglasses', description: 'UV400 polarized sunglasses with premium frame design', price: 34.99, category: 'Accessories', stock: 80 },
    { name: 'Canvas Tote Bag', description: 'Eco-friendly canvas tote bag with custom printed designs', price: 19.99, category: 'Bags', stock: 120 },
  ];

  for (const p of products2) {
    const id = uuidv4();
    store.products.set(id, {
      id,
      vendorId: vendor2Id,
      ...p,
      images: [],
      isActive: true,
      createdAt: new Date(),
      updatedAt: new Date(),
    });
  }

  // Create a customer
  const customerId = uuidv4();
  store.users.set(customerId, {
    id: customerId,
    email: 'customer@edm.com',
    password: await bcrypt.hash('customer123', 10),
    name: 'Jane Customer',
    role: Role.CUSTOMER,
    createdAt: new Date(),
    updatedAt: new Date(),
  });

  // Create a sample order
  const productIds = Array.from(store.products.keys());
  const orderId = uuidv4();
  store.orders.set(orderId, {
    id: orderId,
    customerId,
    vendorId: vendor1Id,
    items: [
      {
        productId: productIds[0],
        productName: 'Wireless Headphones',
        quantity: 1,
        price: 79.99,
      },
    ],
    totalAmount: 79.99,
    status: OrderStatus.CONFIRMED,
    shippingAddress: '123 Main St, New York, NY 10001',
    createdAt: new Date(),
    updatedAt: new Date(),
  });

  console.log('Seed data created successfully!');
  console.log('---');
  console.log('Admin:    admin@edm.com / admin123');
  console.log('Vendor 1: vendor1@edm.com / vendor123');
  console.log('Vendor 2: vendor2@edm.com / vendor123');
  console.log('Customer: customer@edm.com / customer123');
}

seed().catch(console.error);

export { seed };
