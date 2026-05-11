<script setup lang="ts">
import { ref } from 'vue';
import { RouterLink, useRoute } from 'vue-router';

const props = defineProps<{
  isOpen: boolean;
}>();

const route = useRoute();
const activeTab = ref(route.path);

const menuItems = [
  { path: '/dashboard', label: '대시보드', icon: 'dashboard' },
  { path: '/stocks', label: '주식', icon: 'stock' },
  { path: '/banks', label: '은행', icon: 'bank' },
  { path: '/real-estates', label: '부동산', icon: 'house' },
  { path: '/crypto', label: '암호화폐', icon: 'crypto' },
  { path: '/portfolio', label: '포트폴리오', icon: 'chart' },
  { path: '/transactions', label: '거래내역', icon: 'history' },
  { path: '/settings', label: '설정', icon: 'settings' },
];
</script>

<template>
  <aside class="sidebar" :class="{ 'sidebar-open': isOpen }">
    <div class="sidebar-content">
      <div class="sidebar-header">
        <div class="logo">
          <span class="logo-text">Minseo Asset</span>
        </div>
      </div>

      <nav class="sidebar-nav">
        <RouterLink
          v-for="item in menuItems"
          :key="item.path"
          :to="item.path"
          class="nav-item"
        >
          <svg class="nav-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
            />
          </svg>
          <span class="nav-label">{{ item.label }}</span>
        </RouterLink>
      </nav>

      <div class="sidebar-footer">
        <div class="user-info">
          <div class="user-avatar">U</div>
          <div class="user-details">
            <div class="user-name">사용자</div>
            <div class="user-email">user@example.com</div>
          </div>
        </div>
      </div>
    </div>
  </aside>
</template>

<style scoped>
.sidebar {
  width: var(--sidebar-width);
  background: white;
  border-right: 1px solid var(--border-color);
  position: fixed;
  left: 0;
  top: 0;
  bottom: 0;
  transition: transform 0.3s;
}

.sidebar-content {
  height: 100%;
  display: flex;
  flex-direction: column;
}

.sidebar-header {
  padding: 20px;
  border-bottom: 1px solid var(--border-color);
}

.logo {
  font-weight: 700;
  font-size: 1.25rem;
  color: var(--primary-color);
}

.sidebar-nav {
  flex: 1;
  padding: 16px 0;
  overflow-y: auto;
}

.nav-item {
  display: flex;
  align-items: center;
  padding: 12px 20px;
  color: var(--text-secondary);
  text-decoration: none;
  transition: all 0.2s;
}

.nav-item:hover {
  background-color: var(--bg-color);
  color: var(--primary-color);
}

.nav-item.active {
  background-color: var(--primary-color);
  color: white;
}

.nav-icon {
  width: 20px;
  height: 20px;
  margin-right: 12px;
}

.nav-label {
  font-size: 0.9375rem;
}

.sidebar-footer {
  padding: 16px;
  border-top: 1px solid var(--border-color);
}

.user-info {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px;
  background-color: var(--bg-color);
  border-radius: 8px;
}

.user-avatar {
  width: 36px;
  height: 36px;
  background-color: var(--primary-color);
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
}

.user-details {
  flex: 1;
  overflow: hidden;
}

.user-name {
  font-size: 0.875rem;
  font-weight: 500;
  color: var(--text-primary);
}

.user-email {
  font-size: 0.75rem;
  color: var(--text-secondary);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
