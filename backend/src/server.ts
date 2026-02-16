import app from './app';
import { config } from './config';
import { seed } from './seed';
import fs from 'fs';
import path from 'path';

// Ensure uploads directory exists
const uploadsDir = path.join(__dirname, '..', config.uploadDir);
if (!fs.existsSync(uploadsDir)) {
  fs.mkdirSync(uploadsDir, { recursive: true });
}

// Auto-seed data on startup
seed().then(() => {
  app.listen(config.port, () => {
    console.log(`Server running on port ${config.port} in ${config.nodeEnv} mode`);
    console.log(`API available at http://localhost:${config.port}/api`);
  });
});
