import { Request, Response, NextFunction } from 'express';
import { vendorService } from '../services/vendorService';

export const vendorController = {
  getAllVendors(req: Request, res: Response, next: NextFunction) {
    try {
      const vendors = vendorService.getAllVendors();
      res.json({ success: true, data: vendors });
    } catch (err) {
      next(err);
    }
  },

  getActiveVendors(_req: Request, res: Response, next: NextFunction) {
    try {
      const vendors = vendorService.getActiveVendors();
      res.json({ success: true, data: vendors });
    } catch (err) {
      next(err);
    }
  },

  getVendorById(req: Request, res: Response, next: NextFunction) {
    try {
      const vendor = vendorService.getVendorById(req.params.id);
      res.json({ success: true, data: vendor });
    } catch (err) {
      next(err);
    }
  },

  getMyProfile(req: Request, res: Response, next: NextFunction) {
    try {
      const vendor = vendorService.getVendorByUserId(req.user!.userId);
      res.json({ success: true, data: vendor });
    } catch (err) {
      next(err);
    }
  },

  updateMyProfile(req: Request, res: Response, next: NextFunction) {
    try {
      const vendor = vendorService.updateVendorProfile(req.user!.userId, req.body);
      res.json({ success: true, data: vendor });
    } catch (err) {
      next(err);
    }
  },

  toggleVendorStatus(req: Request, res: Response, next: NextFunction) {
    try {
      const vendor = vendorService.toggleVendorStatus(req.params.id);
      res.json({ success: true, data: vendor });
    } catch (err) {
      next(err);
    }
  },

  getAnalytics(req: Request, res: Response, next: NextFunction) {
    try {
      const analytics = vendorService.getVendorAnalytics(req.user!.userId);
      res.json({ success: true, data: analytics });
    } catch (err) {
      next(err);
    }
  },
};
