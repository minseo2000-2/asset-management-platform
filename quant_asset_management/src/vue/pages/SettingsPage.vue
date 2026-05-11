<template>
  <div class="settings-page">
    <h1 class="page-title">설정</h1>

    <div class="settings-section">
      <h2 class="section-title">계정 설정</h2>
      <div class="settings-form">
        <div class="form-group">
          <label class="form-label">이름</label>
          <input type="text" class="form-input" placeholder="이름을 입력하세요">
        </div>
        <div class="form-group">
          <label class="form-label">이메일</label>
          <input type="email" class="form-input" placeholder="이메일을 입력하세요">
        </div>
        <div class="form-group">
          <label class="form-label">암호 변경</label>
          <div class="password-group">
            <input type="password" class="form-input" placeholder="현재 암호">
            <input type="password" class="form-input" placeholder="새 암호">
            <input type="password" class="form-input" placeholder="새 암호 확인">
          </div>
        </div>
        <button class="btn-primary">정보 저장</button>
      </div>
    </div>

    <div class="settings-section">
      <h2 class="section-title">연결된 계정</h2>
      <div class="connected-accounts">
        <div class="account-item">
          <div class="account-header">
            <div class="account-icon bank-icon"></div>
            <div class="account-info">
              <h3 class="account-name">KB국민은행</h3>
              <span class="account-status connected">연결됨</span>
            </div>
            <button class="btn-secondary">연결 해제</button>
          </div>
        </div>
        <div class="account-item">
          <div class="account-header">
            <div class="account-icon stock-icon"></div>
            <div class="account-info">
              <h3 class="account-name">KB securities</h3>
              <span class="account-status connected">연결됨</span>
            </div>
            <button class="btn-secondary">연결 해제</button>
          </div>
        </div>
      </div>
    </div>

    <div class="settings-section">
      <h2 class="section-title">앱 설정</h2>
      <div class="app-settings">
        <div class="setting-item">
          <span class="setting-label">공통 통화</span>
          <select class="form-select">
            <option>KRW</option>
            <option>USD</option>
            <option>JPY</option>
          </select>
        </div>
        <div class="setting-item">
          <span class="setting-label">가격 업데이트 주기</span>
          <select class="form-select">
            <option>수동</option>
            <option>1일</option>
            <option>1주</option>
          </select>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.settings-page {
  max-width: 800px;
}

.page-title {
  font-size: 1.5rem;
  font-weight: 600;
  margin-bottom: 24px;
}

.settings-section {
  background: white;
  padding: 24px;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  margin-bottom: 24px;
}

.section-title {
  font-size: 1.25rem;
  font-weight: 600;
  margin-bottom: 20px;
  padding-bottom: 16px;
  border-bottom: 1px solid var(--border-color);
}

.settings-form {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.form-label {
  font-size: 0.875rem;
  font-weight: 500;
  color: var(--text-primary);
}

.form-input {
  padding: 10px 16px;
  border: 1px solid var(--border-color);
  border-radius: 6px;
  font-size: 0.9375rem;
  transition: border-color 0.2s;
}

.form-input:focus {
  outline: none;
  border-color: var(--primary-color);
}

.password-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.btn-primary {
  padding: 12px 24px;
  background: var(--primary-color);
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 0.9375rem;
  font-weight: 500;
  transition: background 0.2s;
}

.btn-primary:hover {
  background: var(--primary-dark);
}

.connected-accounts {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.account-item {
  border: 1px solid var(--border-color);
  border-radius: 8px;
  overflow: hidden;
}

.account-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px;
  background: var(--bg-color);
}

.account-icon {
  width: 40px;
  height: 40px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 600;
  margin-right: 12px;
}

.bank-icon {
  background: var(--primary-color);
}

.stock-icon {
  background: var(--success-color);
}

.account-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.account-name {
  font-weight: 500;
  color: var(--text-primary);
}

.account-status {
  font-size: 0.75rem;
  padding: 2px 8px;
  background: var(--success-color);
  color: white;
  border-radius: 4px;
  width: fit-content;
}

.btn-secondary {
  padding: 8px 16px;
  background: white;
  border: 1px solid var(--border-color);
  border-radius: 6px;
  cursor: pointer;
  font-size: 0.875rem;
  color: var(--text-primary);
  transition: all 0.2s;
}

.btn-secondary:hover {
  background: var(--bg-color);
  border-color: var(--text-secondary);
}

.app-settings {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.setting-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.form-select {
  padding: 8px 12px;
  border: 1px solid var(--border-color);
  border-radius: 6px;
  font-size: 0.9375rem;
}
</style>
