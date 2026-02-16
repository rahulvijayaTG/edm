import { Request, Response, NextFunction } from 'express';
import { adminService } from '../services/adminService';

export const adminController = {
  getDashboardStats(_req: Request, res: Response, next: NextFunction) {
    try {
      const stats = adminService.getDashboardStats();
      res.json({ success: true, data: stats });
    } catch (err) {
      next(err);
    }
  },

  getPlatformSettings(_req: Request, res: Response, next: NextFunction) {
    try {
      const settings = adminService.getPlatformSettings();
      res.json({ success: true, data: settings });
    } catch (err) {
      next(err);
    }
  },

  updatePlatformSettings(req: Request, res: Response, next: NextFunction) {
    try {
      const settings = adminService.updatePlatformSettings(req.body);
      res.json({ success: true, data: settings });
    } catch (err) {
      next(err);
    }
  },
};
