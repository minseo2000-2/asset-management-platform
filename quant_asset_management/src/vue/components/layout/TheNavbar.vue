<script setup lang="ts">
import { ref } from 'vue';
import { RouterLink } from 'vue-router';

const props = defineProps<{
  isOpen: boolean;
}>();

const emit = defineEmits<{
  (e: 'toggle-sidebar'): void;
}>();

const userMenuOpen = ref(false);
</script>

<template>
  <header class="navbar">
    <div class="navbar-content">
      <div class="navbar-left">
        <button
          class="sidebar-toggle"
          @click="emit('toggle-sidebar')"
        >
          <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
          </svg>
        </button>
        <div class="brand">
          <span class="brand-text">Minseo Asset</span>
        </div>
      </div>

      <nav class="navbar-nav">
        <RouterLink to="/dashboard" class="nav-link">대시보드</RouterLink>
        <RouterLink to="/stocks" class="nav-link">주식</RouterLink>
        <RouterLink to="/banks" class="nav-link">은행</RouterLink>
        <RouterLink to="/real-estates" class="nav-link">부동산</RouterLink>
        <RouterLink to="/portfolio" class="nav-link">포트폴리오</RouterLink>
      </nav>

      <div class="navbar-right">
        <button class="icon-btn" title="알림">
          <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path>
          </svg>
        </button>
        <div class="user-menu">
          <button class="user-btn" @click="userMenuOpen = !userMenuOpen">
            <span class="user-name">사용자</span>
            <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
            </svg>
          </button>
          <div v-if="userMenuOpen" class="user-dropdown">
            <RouterLink to="/settings" class="dropdown-item">설정</RouterLink>
            <a href="#" class="dropdown-item">로그아웃</a>
          </div>
        </div>
      </div>
    </div>
  </header>
</template>

<style scoped>
.navbar {
  background: white;
  border-bottom: 1px solid var(--border-color);
  padding: 0 24px;
  height: 64px;
  display: flex;
  align-items: center;
}

.navbar-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.navbar-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.sidebar-toggle {
  background: none;
  border: none;
  cursor: pointer;
  padding: 8px;
  color: var(--text-secondary);
}

.brand {
  font-weight: 600;
  font-size: 1.25rem;
  color: var(--primary-color);
}

.navbar-nav {
  display: flex;
  gap: 8px;
}

.nav-link {
  padding: 8px 16px;
  color: var(--text-secondary);
  text-decoration: none;
  border-radius: 6px;
  transition: all 0.2s;
}

.nav-link:hover,
.nav-link.active {
  background-color: var(--primary-color);
  color: white;
}

.navbar-right {
  display: flex;
  align-items: center;
  gap: 16px;
}

.icon-btn {
  background: none;
  border: none;
  cursor: pointer;
  padding: 8px;
  color: var(--text-secondary);
  position: relative;
}

.icon-btn .icon {
  width: 24px;
  height: 24px;
}

.user-menu {
  position: relative;
}

.user-btn {
  display: flex;
  align-items: center;
  gap: 8px;
  background: none;
  border: 1px solid var(--border-color);
  padding: 4px 12px;
  border-radius: 20px;
  cursor: pointer;
}

.user-name {
  font-size: 0.875rem;
  color: var(--text-primary);
}

.user-dropdown {
  position: absolute;
  right: 0;
  top: 100%;
  margin-top: 8px;
  background: white;
  border: 1px solid var(--border-color);
  border-radius: 8px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  min-width: 120px;
  z-index: 10;
}

.dropdown-item {
  display: block;
  padding: 8px 16px;
  color: var(--text-primary);
  text-decoration: none;
  font-size: 0.875rem;
}

.dropdown-item:hover {
  background-color: var(--bg-color);
}
</style>
