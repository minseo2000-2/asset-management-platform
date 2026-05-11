<script setup lang="ts">
import { ref } from 'vue';
import { RouterLink, useRouter } from 'vue-router';
import { AuthStore } from '../stores/auth';

const router = useRouter();
const email = ref('');
const password = ref('');
const loading = ref(false);
const error = ref('');

const handleSubmit = async (e: Event) => {
  e.preventDefault();
  loading.value = true;
  error.value = '';

  try {
    // API call to login
    await new Promise(resolve => setTimeout(resolve, 1000)); // Mock
    AuthStore.login('mock-token', { id: 1, name: '사용자', email: email.value });
    router.push('/dashboard');
  } catch (err) {
    error.value = '로그인에 실패했습니다. 다시 시도해주세요.';
  } finally {
    loading.value = false;
  }
};
</script>

<template>
  <div class="login-page">
    <div class="login-container">
      <div class="login-header">
        <h1 class="login-title">Minseo Asset</h1>
        <p class="login-subtitle">개인 자산 통합 관리</p>
      </div>

      <form class="login-form" @submit="handleSubmit">
        <div class="form-group">
          <label class="form-label">이메일</label>
          <input
            v-model="email"
            type="email"
            class="form-input"
            placeholder="example@email.com"
            required
          >
        </div>

        <div class="form-group">
          <label class="form-label">암호</label>
          <input
            v-model="password"
            type="password"
            class="form-input"
            placeholder="••••••••"
            required
          >
        </div>

        <div v-if="error" class="error-message">
          {{ error }}
        </div>

        <button type="submit" :disabled="loading" class="btn-primary">
          {{ loading ? '로그인 중...' : '로그인' }}
        </button>
      </form>

      <div class="login-footer">
        <p class="footer-text">
          계정이 없으신가요?
          <RouterLink to="/auth/register" class="footer-link">회원가입</RouterLink>
        </p>
      </div>
    </div>
  </div>
</template>

<style scoped>
.login-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.login-container {
  background: white;
  padding: 40px;
  border-radius: 16px;
  width: 100%;
  max-width: 400px;
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
}

.login-header {
  text-align: center;
  margin-bottom: 32px;
}

.login-title {
  font-size: 2rem;
  font-weight: 700;
  color: var(--primary-color);
  margin-bottom: 8px;
}

.login-subtitle {
  color: var(--text-secondary);
}

.form-group {
  margin-bottom: 16px;
}

.form-label {
  display: block;
  margin-bottom: 8px;
  font-size: 0.875rem;
  font-weight: 500;
  color: var(--text-primary);
}

.form-input {
  width: 100%;
  padding: 12px 16px;
  border: 1px solid var(--border-color);
  border-radius: 8px;
  font-size: 0.9375rem;
  transition: border-color 0.2s;
}

.form-input:focus {
  outline: none;
  border-color: var(--primary-color);
}

.error-message {
  padding: 12px;
  margin-bottom: 16px;
  background: #fef2f2;
  border: 1px solid #fecaca;
  border-radius: 8px;
  color: var(--danger-color);
  font-size: 0.875rem;
}

.btn-primary {
  width: 100%;
  padding: 14px;
  background: var(--primary-color);
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: background 0.2s;
}

.btn-primary:hover {
  background: var(--primary-dark);
}

.btn-primary:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.login-footer {
  margin-top: 24px;
  text-align: center;
}

.footer-text {
  color: var(--text-secondary);
  font-size: 0.875rem;
}

.footer-link {
  color: var(--primary-color);
  text-decoration: none;
  font-weight: 500;
}

.footer-link:hover {
  text-decoration: underline;
}
</style>
