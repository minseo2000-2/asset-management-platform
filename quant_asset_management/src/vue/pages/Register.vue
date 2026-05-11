<script setup lang="ts">
import { ref } from 'vue';
import { RouterLink, useRouter } from 'vue-router';

const router = useRouter();
const name = ref('');
const email = ref('');
const password = ref('');
const confirmPassword = ref('');
const loading = ref(false);
const error = ref('');

const handleSubmit = async (e: Event) => {
  e.preventDefault();
  loading.value = true;
  error.value = '';

  try {
    // API call to register
    await new Promise(resolve => setTimeout(resolve, 1000)); // Mock
    router.push('/auth/login');
  } catch (err) {
    error.value = '회원가입에 실패했습니다. 다시 시도해주세요.';
  } finally {
    loading.value = false;
  }
};
</script>

<template>
  <div class="register-page">
    <div class="register-container">
      <div class="register-header">
        <h1 class="register-title">회원가입</h1>
        <p class="register-subtitle">새 계정을 생성하세요</p>
      </div>

      <form class="register-form" @submit="handleSubmit">
        <div class="form-group">
          <label class="form-label">이름</label>
          <input
            v-model="name"
            type="text"
            class="form-input"
            placeholder="이름을 입력하세요"
            required
          >
        </div>

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

        <div class="form-group">
          <label class="form-label">암호 확인</label>
          <input
            v-model="confirmPassword"
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
          {{ loading ? '처리 중...' : '회원가입' }}
        </button>
      </form>

      <div class="register-footer">
        <p class="footer-text">
          이미 계정이 있으신가요?
          <RouterLink to="/auth/login" class="footer-link">로그인</RouterLink>
        </p>
      </div>
    </div>
  </div>
</template>

<style scoped>
.register-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.register-container {
  background: white;
  padding: 40px;
  border-radius: 16px;
  width: 100%;
  max-width: 400px;
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
}

.register-header {
  text-align: center;
  margin-bottom: 32px;
}

.register-title {
  font-size: 2rem;
  font-weight: 700;
  color: var(--primary-color);
  margin-bottom: 8px;
}

.register-subtitle {
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

.register-footer {
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
