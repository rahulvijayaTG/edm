import DataStore from '../models/DataStore';
import { User } from '../types';

const store = DataStore.getInstance();

export const userRepository = {
  findAll(): User[] {
    return Array.from(store.users.values());
  },

  findById(id: string): User | undefined {
    return store.users.get(id);
  },

  findByEmail(email: string): User | undefined {
    return Array.from(store.users.values()).find((u) => u.email === email);
  },

  create(user: User): User {
    store.users.set(user.id, user);
    return user;
  },

  update(id: string, data: Partial<User>): User | undefined {
    const user = store.users.get(id);
    if (!user) return undefined;
    const updated = { ...user, ...data, updatedAt: new Date() };
    store.users.set(id, updated);
    return updated;
  },

  delete(id: string): boolean {
    return store.users.delete(id);
  },
};
