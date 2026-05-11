import { createApp } from 'vue';
import { createPinia } from 'pinia';
import router from './router';
import App from './App.vue';
import './styles/index.css';

// Create app instance
const app = createApp(App);

// Use plugins
app.use(createPinia());
app.use(router);

// Restore auth state from localStorage
import { AuthStore } from './stores/auth';
AuthStore.restore();

// Mount app
app.mount('#app');
