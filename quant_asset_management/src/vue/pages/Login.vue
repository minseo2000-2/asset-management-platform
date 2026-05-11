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
    <!-- Decorative background elements -->
    <div class="bg-decoration bg-decoration-1"></div>
    <div class="bg-decoration bg-decoration-2"></div>
    <div class="bg-decoration bg-decoration-3"></div>

    <div class="login-container">
      <div class="login-header">
        <div class="logo-container">
          <svg class="logo-icon" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M24 4L4 14L24 24L44 14L24 4Z" fill="var(--primary-color)" />
            <path d="M4 24L24 34L44 24" stroke="var(--primary-color)" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" />
            <path d="M4 34L24 44L44 34" stroke="var(--primary-color)" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" />
          </svg>
          <div class="logo-text">
            <h1 class="login-title">Minseo Asset</h1>
          </div>
        </div>
        <p class="login-subtitle">개인 자산 통합 관리 플랫폼</p>
      </div>

      <div class="social-login">
        <button type="button" class="social-btn google-btn">
          <svg class="social-icon" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4" />
            <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853" />
            <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05" />
            <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335" />
          </svg>
          <span>Google로 계속하기</span>
        </button>
        <button type="button" class="social-btn github-btn">
          <svg class="social-icon" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
            <path d="M12 0C5.37 0 0 5.37 0 12c0 5.31 3.435 9.795 8.205 11.385.6.105.825-.255.825-.57 0-.285-.015-1.04-.015-2.04-3.338.72-4.042-1.61-4.042-1.61-.546-1.385-1.335-1.755-1.335-1.755-1.087-.745.083-.73.083-.73 1.205.085 1.84 1.235 1.84 1.235 1.07 1.835 2.805 1.305 3.495.995.108-.775.418-1.305.762-1.605-2.665-.3-5.466-1.335-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.305-.54-1.525.105-3.175 0 0 1.005-.315 3.3 1.23.96-.27 1.98-.405 3-.405 1.02 0 2.04.135 3 .405 2.295-1.55 3.3-1.23 3.3-1.23.645 1.65.24 2.875.12 3.175.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.435.375.81 1.095.81 2.22 0 1.605-.015 2.895-.015 3.285 0 .315.225.69.825.57C20.565 21.795 24 17.31 24 12c0-6.63-5.37-12-12-12z" />
          </svg>
          <span>GitHub로 계속하기</span>
        </button>
      </div>

      <div class="divider">
        <span>또는 이메일로 로그인</span>
      </div>

      <form class="login-form" @submit="handleSubmit">
        <div class="form-group">
          <label class="form-label" for="email">이메일</label>
          <input
            id="email"
            v-model="email"
            type="email"
            class="form-input"
            placeholder="example@email.com"
            required
            autocomplete="email"
          >
        </div>

        <div class="form-group">
          <label class="form-label" for="password">비밀번호</label>
          <input
            id="password"
            v-model="password"
            type="password"
            class="form-input"
            placeholder="••••••••"
            required
            autocomplete="current-password"
          >
        </div>

        <div class="form-options">
          <label class="remember-me">
            <input type="checkbox">
            <span>로그인 상태 유지</span>
          </label>
          <a href="#" class="forgot-password">비밀번호 재설정</a>
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
  position: relative;
  overflow: hidden;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
}

.login-page::before {
  content: '';
  position: absolute;
  width: 600px;
  height: 600px;
  background: radial-gradient(circle, rgba(255, 255, 255, 0.15) 0%, transparent 60%);
  border-radius: 50%;
  top: -200px;
  right: -100px;
  animation: float 20s infinite alternate;
}

.login-page::after {
  content: '';
  position: absolute;
  width: 400px;
  height: 400px;
  background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 60%);
  border-radius: 50%;
  bottom: -100px;
  left: -100px;
  animation: float 25s infinite alternate-reverse;
}

@keyframes float {
  0% {
    transform: translate(0, 0) scale(1);
  }
  100% {
    transform: translate(50px, 50px) scale(1.1);
  }
}

.bg-decoration {
  position: absolute;
  border-radius: 50%;
  filter: blur(80px);
  opacity: 0.4;
  z-index: 0;
}

.bg-decoration-1 {
  width: 300px;
  height: 300px;
  background: #667eea;
  top: 10%;
  left: 10%;
}

.bg-decoration-2 {
  width: 200px;
  height: 200px;
  background: #f093fb;
  top: 20%;
  right: 20%;
}

.bg-decoration-3 {
  width: 250px;
  height: 250px;
  background: #4facfe;
  bottom: 10%;
  left: 20%;
}

.login-container {
  background: white;
  padding: 48px 40px;
  border-radius: 24px;
  width: 100%;
  max-width: 480px;
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
  position: relative;
  z-index: 1;
  transition: transform 0.3s ease;
}

.login-container:hover {
  transform: translateY(-2px);
}

.login-header {
  text-align: center;
  margin-bottom: 40px;
}

.logo-container {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  margin-bottom: 16px;
}

.logo-icon {
  width: 48px;
  height: 48px;
}

.logo-text .login-title {
  font-size: 1.75rem;
  font-weight: 700;
  background: linear-gradient(135deg, var(--primary-color), #8b5cf6);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  margin: 0;
}

.login-subtitle {
  color: var(--text-secondary);
  font-size: 0.9375rem;
  margin: 0;
}

.social-login {
  display: flex;
  flex-direction: column;
  gap: 12px;
  margin-bottom: 32px;
}

.social-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  padding: 12px 20px;
  border: 1px solid var(--border-color);
  border-radius: 12px;
  background: white;
  color: var(--text-primary);
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
}

.social-btn:hover {
  background: #f8fafc;
  border-color: var(--primary-color);
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.social-icon {
  width: 20px;
  height: 20px;
}

.google-btn .social-icon {
  width: 22px;
  height: 22px;
}

.divider {
  display: flex;
  align-items: center;
  text-align: center;
  margin: 24px 0 32px;
  color: var(--text-secondary);
  font-size: 0.875rem;
}

.divider::before,
.divider::after {
  content: '';
  flex: 1;
  border-bottom: 1px solid var(--border-color);
}

.divider::before {
  margin-right: 16px;
}

.divider::after {
  margin-left: 16px;
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
  padding: 14px 16px;
  border: 1.5px solid var(--border-color);
  border-radius: 12px;
  font-size: 0.9375rem;
  transition: all 0.2s;
  background: #f8fafc;
}

.form-input:focus {
  outline: none;
  border-color: var(--primary-color);
  background: white;
  box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
}

.form-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  font-size: 0.875rem;
}

.remember-me {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  user-select: none;
}

.remember-me input {
  width: 18px;
  height: 18px;
  accent-color: var(--primary-color);
}

.forgot-password {
  color: var(--primary-color);
  text-decoration: none;
  font-weight: 500;
}

.forgot-password:hover {
  text-decoration: underline;
}

.error-message {
  padding: 14px;
  margin-bottom: 20px;
  background: #fef2f2;
  border: 1px solid #fecaca;
  border-radius: 12px;
  color: var(--danger-color);
  font-size: 0.875rem;
  display: flex;
  align-items: center;
  gap: 8px;
}

.btn-primary {
  width: 100%;
  padding: 16px;
  background: linear-gradient(135deg, var(--primary-color), #6366f1);
  color: white;
  border: none;
  border-radius: 12px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
  box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
}

.btn-primary:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(59, 130, 246, 0.4);
}

.btn-primary:active:not(:disabled) {
  transform: translateY(0);
}

.btn-primary:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  transform: none;
}

.login-footer {
  margin-top: 32px;
  text-align: center;
  padding-top: 24px;
  border-top: 1px solid var(--border-color);
}

.footer-text {
  color: var(--text-secondary);
  font-size: 0.9375rem;
  margin: 0;
}

.footer-link {
  color: var(--primary-color);
  text-decoration: none;
  font-weight: 600;
}

.footer-link:hover {
  text-decoration: underline;
}

@media (max-width: 640px) {
  .login-container {
    padding: 32px 24px;
    max-width: 100%;
    margin: 0 16px;
  }

  .login-title {
    font-size: 1.5rem;
  }

  .social-btn {
    padding: 10px 16px;
    font-size: 0.8125rem;
  }
}
</style>
