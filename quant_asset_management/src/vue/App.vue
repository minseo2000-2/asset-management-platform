<script setup lang="ts">
import { ref, computed } from 'vue';
import { useRoute } from 'vue-router';
import TheNavbar from './components/layout/TheNavbar.vue';
import TheSidebar from './components/layout/TheSidebar.vue';
import TheFooter from './components/layout/TheFooter.vue';

const route = useRoute();
const isDashboard = computed(() => route.path === '/dashboard');
const showLayout = computed(() => !route.path.startsWith('/auth'));

const sidebarOpen = ref(true);
</script>

<template>
  <div class="app-container">
    <TheSidebar v-if="showLayout" :is-open="sidebarOpen" />

    <div class="main-content" :class="{ 'sidebar-closed': !sidebarOpen }">
      <TheNavbar
        v-if="showLayout"
        :is-open="sidebarOpen"
        @toggle-sidebar="sidebarOpen = !sidebarOpen"
      />

      <main class="content">
        <router-view />
      </main>

      <TheFooter v-if="showLayout" />
    </div>
  </div>
</template>

<style scoped>
.app-container {
  display: flex;
  min-height: 100vh;
  background-color: #f5f7fa;
}

.main-content {
  flex: 1;
  transition: margin-left 0.3s;
}

.content {
  padding: 24px;
  min-height: calc(100vh - 80px);
}
</style>
