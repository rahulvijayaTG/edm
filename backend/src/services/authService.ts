import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { v4 as uuidv4 } from 'uuid';
import { config } from '../config';
import { Role, User, JwtPayload } from '../types';
import { userRepository } from '../repositories/userRepository';
import { vendorRepository } from '../repositories/vendorRepository';
import { ApiError } from '../utils/ApiError';

const generateToken = (payload: JwtPayload): string => {
  return jwt.sign(payload, config.jwtSecret, { expiresIn: config.jwtExpiresIn } as jwt.SignOptions);
};

const sanitizeUser = (user: User) => {
  const { password, ...rest } = user;
  return rest;
};

export const authService = {
  async register(email: string, passwordRaw: string, name: string, role: string = 'customer') {
    const existing = userRepository.findByEmail(email);
    if (existing) {
      throw ApiError.conflict('Email already registered');
    }

    const hashedPassword = await bcrypt.hash(passwordRaw, 10);
    const user: User = {
      id: uuidv4(),
      email,
      password: hashedPassword,
      name,
      role: role as Role,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    userRepository.create(user);

    // If vendor role, create vendor profile
    if (role === Role.VENDOR) {
      vendorRepository.create({
        id: uuidv4(),
        userId: user.id,
        storeName: `${name}'s Store`,
        description: '',
        logo: '',
        theme: 'default',
        isActive: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      });
    }

    const token = generateToken({ userId: user.id, email: user.email, role: user.role });
    return { user: sanitizeUser(user), token };
  },

  async login(email: string, password: string) {
    const user = userRepository.findByEmail(email);
    if (!user) {
      throw ApiError.unauthorized('Invalid email or password');
    }

    const isValid = await bcrypt.compare(password, user.password);
    if (!isValid) {
      throw ApiError.unauthorized('Invalid email or password');
    }

    const token = generateToken({ userId: user.id, email: user.email, role: user.role });
    return { user: sanitizeUser(user), token };
  },

  getProfile(userId: string) {
    const user = userRepository.findById(userId);
    if (!user) throw ApiError.notFound('User not found');
    return sanitizeUser(user);
  },
};
