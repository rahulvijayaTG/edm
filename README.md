# EDM Marketplace - Multi-Vendor E-Commerce Platform

A full-stack multi-vendor e-commerce application built with React, Node.js, Express, and TypeScript.

## Tech Stack

### Backend
- **Runtime**: Node.js with TypeScript
- **Framework**: Express.js
- **Authentication**: JWT (JSON Web Tokens)
- **Validation**: Zod
- **Architecture**: Clean layered architecture (Routes → Controllers → Services → Repositories → Models)
- **Storage**: In-memory data store (singleton pattern with Maps)

### Frontend
- **Framework**: React with TypeScript
- **State Management**: Redux Toolkit
- **Routing**: React Router v6
- **HTTP Client**: Axios
- **Styling**: Custom CSS

## Features

### Multi-Vendor Support
- Vendor registration and login
- Individual vendor dashboards
- Product management (CRUD operations)
- Store customization (logo, theme, description)
- Data isolation per vendor

### Admin Panel
- Global dashboard with statistics
- Vendor management (activate/deactivate)
- View all products across vendors
- View all orders
- Platform settings management

### Vendor Dashboard
- Analytics overview (products, orders, revenue)
- Product management (add, edit, delete)
- Order management with status updates
- Store settings customization

### Customer Store
- Browse all products and vendors
- Vendor-specific store pages (`/store/:vendorId`)
- Product detail pages
- Shopping cart with quantity management
- Checkout flow with order placement
- Order history

## Project Structure

```
edm/
├── backend/
│   ├── src/
│   │   ├── config/          # Environment configuration
│   │   ├── controllers/     # Request handlers
│   │   ├── middleware/       # Auth, validation, error handling, uploads
│   │   ├── models/          # In-memory data store
│   │   ├── repositories/    # Data access layer
│   │   ├── routes/          # API route definitions
│   │   ├── services/        # Business logic
│   │   ├── types/           # TypeScript type definitions
│   │   ├── utils/           # Utilities (validation schemas, error classes)
│   │   ├── app.ts           # Express app setup
│   │   ├── server.ts        # Server entry point
│   │   └── seed.ts          # Seed data script
│   ├── .env.example
│   ├── package.json
│   └── tsconfig.json
├── frontend/
│   ├── src/
│   │   ├── api/             # API client functions
│   │   ├── components/      # Reusable UI components
│   │   │   ├── common/      # Shared components (Loading, ProtectedRoute)
│   │   │   └── layout/      # Layout components (Navbar, Sidebar)
│   │   ├── hooks/           # Custom React hooks
│   │   ├── pages/           # Page components
│   │   │   ├── admin/       # Admin dashboard pages
│   │   │   ├── auth/        # Login & Register pages
│   │   │   ├── store/       # Customer-facing pages
│   │   │   └── vendor/      # Vendor dashboard pages
│   │   ├── store/           # Redux store & slices
│   │   ├── types/           # TypeScript type definitions
│   │   ├── App.tsx          # Main app with routing
│   │   └── index.tsx        # Entry point with Redux Provider
│   ├── .env.example
│   └── package.json
└── README.md
```

## Database Schema (In-Memory)

Since there's no persistent database, data is stored in memory using JavaScript Maps:

- **Users**: `Map<string, User>` - id, email, password (hashed), name, role
- **Vendors**: `Map<string, Vendor>` - id, userId, storeName, description, logo, theme, isActive
- **Products**: `Map<string, Product>` - id, vendorId, name, description, price, category, images, stock, isActive
- **Orders**: `Map<string, Order>` - id, customerId, vendorId, items, totalAmount, status, shippingAddress

⚠️ **Note**: All data resets when the server restarts. The server auto-seeds sample data on startup.

## Setup Instructions

### Prerequisites
- Node.js (v18 or higher)
- npm

### Backend Setup

```bash
cd backend

# Install dependencies
npm install

# Copy environment variables
cp .env.example .env

# Start development server (auto-seeds data)
npm run dev
```

The backend runs on `http://localhost:5000`.

### Frontend Setup

```bash
cd frontend

# Install dependencies
npm install

# Start development server
npm start
```

The frontend runs on `http://localhost:3000`.

## Environment Configuration

### Backend (.env)
| Variable | Default | Description |
|----------|---------|-------------|
| `PORT` | `5000` | Server port |
| `JWT_SECRET` | (set in .env) | JWT signing secret |
| `JWT_EXPIRES_IN` | `7d` | Token expiration |
| `CORS_ORIGIN` | `http://localhost:3000` | Allowed CORS origin |
| `NODE_ENV` | `development` | Environment mode |
| `UPLOAD_DIR` | `uploads` | File upload directory |

### Frontend (.env)
| Variable | Default | Description |
|----------|---------|-------------|
| `REACT_APP_API_URL` | `http://localhost:5000/api` | Backend API URL |

## Start Commands

```bash
# Backend
cd backend && npm run dev    # Development with hot reload
cd backend && npm run build  # Build for production
cd backend && npm start      # Run production build
cd backend && npm run seed   # Run seed script separately

# Frontend
cd frontend && npm start     # Development server
cd frontend && npm run build # Production build
```

## Seed Data (Auto-loaded on server start)

| Role | Email | Password |
|------|-------|----------|
| Admin | admin@edm.com | admin123 |
| Vendor 1 | vendor1@edm.com | vendor123 |
| Vendor 2 | vendor2@edm.com | vendor123 |
| Customer | customer@edm.com | customer123 |

## API Endpoints

### Auth
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login
- `GET /api/auth/profile` - Get current user profile

### Vendors
- `GET /api/vendors/active` - List active vendors (public)
- `GET /api/vendors/:id` - Get vendor by ID (public)
- `GET /api/vendors/me/profile` - Get vendor's own profile
- `PUT /api/vendors/me/profile` - Update vendor profile
- `GET /api/vendors/me/analytics` - Get vendor analytics
- `GET /api/vendors` - List all vendors (admin)
- `PATCH /api/vendors/:id/toggle-status` - Toggle vendor status (admin)

### Products
- `GET /api/products/public` - List active products (public)
- `GET /api/products/public/:id` - Get product by ID (public)
- `GET /api/products/vendor/:vendorId` - Get products by vendor (public)
- `GET /api/products/my` - Get vendor's products
- `POST /api/products` - Create product (vendor)
- `PUT /api/products/:id` - Update product (vendor)
- `DELETE /api/products/:id` - Delete product (vendor)
- `POST /api/products/:id/images` - Upload product images (vendor)
- `GET /api/products` - List all products (admin)

### Orders
- `POST /api/orders` - Create order (customer)
- `GET /api/orders/my` - Get customer's orders
- `GET /api/orders/vendor` - Get vendor's orders
- `PATCH /api/orders/:id/status` - Update order status (vendor)
- `GET /api/orders` - List all orders (admin)

### Admin
- `GET /api/admin/dashboard` - Dashboard statistics
- `GET /api/admin/settings` - Platform settings
- `PUT /api/admin/settings` - Update platform settings
