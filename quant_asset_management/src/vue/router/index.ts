import { createRouter, createWebHistory } from 'vue-router';
import { AuthStore } from '../stores/auth';

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/auth',
      component: () => import('../pages/AuthPage.vue'),
      children: [
        {
          path: 'login',
          name: 'Login',
          component: () => import('../pages/Login.vue'),
        },
        {
          path: 'register',
          name: 'Register',
          component: () => import('../pages/Register.vue'),
        },
      ],
    },
    {
      path: '/dashboard',
      component: () => import('../pages/DashboardPage.vue'),
      meta: { requiresAuth: true },
    },
    {
      path: '/stocks',
      component: () => import('../pages/StocksPage.vue'),
      meta: { requiresAuth: true },
    },
    {
      path: '/banks',
      component: () => import('../pages/BanksPage.vue'),
      meta: { requiresAuth: true },
    },
    {
      path: '/real-estates',
      component: () => import('../pages/RealEstatesPage.vue'),
      meta: { requiresAuth: true },
    },
    {
      path: '/crypto',
      component: () => import('../pages/CryptoPage.vue'),
      meta: { requiresAuth: true },
    },
    {
      path: '/portfolio',
      component: () => import('../pages/PortfolioPage.vue'),
      meta: { requiresAuth: true },
    },
    {
      path: '/settings',
      component: () => import('../pages/SettingsPage.vue'),
      meta: { requiresAuth: true },
    },
    {
      path: '/',
      redirect: '/dashboard',
    },
  ],
});

router.beforeEach((to, from, next) => {
  const requiresAuth = to.matched.some(record => record.meta.requiresAuth);
  const isAuthenticated = AuthStore.state.isLoggedIn;

  if (requiresAuth && !isAuthenticated) {
    next('/auth/login');
  } else {
    next();
  }
});

export default router;
