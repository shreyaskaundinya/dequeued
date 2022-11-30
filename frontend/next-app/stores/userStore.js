import create from 'zustand';

export const useUserStore = create((set) => ({
    user: {},
    setUser: (user) => set((state) => ({ user: user })),
}));
