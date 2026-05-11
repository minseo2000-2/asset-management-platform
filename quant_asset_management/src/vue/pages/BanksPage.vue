<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { RouterLink } from 'vue-router';

interface BankAccount {
  id: number;
  bankName: string;
  accountNumber: string;
  accountType: string;
  balance: number;
  interestRate: number;
  accountName: string;
  isPrimary: boolean;
}

const accounts = ref<BankAccount[]>([]);
const showDialog = ref(false);
const totalBalance = computed(() => accounts.value.reduce((sum, a) => sum + a.balance, 0));

const loadAccounts = async () => {
  // API call to fetch bank accounts
};

onMounted(loadAccounts);
</script>

<template>
  <div class="banks-page">
    <div class="page-header">
      <h1 class="page-title">은행 계좌</h1>
      <button class="btn-primary" @click="showDialog = true">
        <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
        </svg>
        계좌 추가
      </button>
    </div>

    <!-- Total Balance Card -->
    <div class="card total-balance-card">
      <h3 class="card-title">전체 잔액</h3>
      <div class="total-balance">₩{{ totalBalance.toLocaleString() }}</div>
    </div>

    <!-- Accounts Grid -->
    <div class="accounts-grid">
      <div v-for="account in accounts" :key="account.id" class="account-card">
        <div class="account-header">
          <div class="bank-info">
            <h4 class="bank-name">{{ account.bankName }}</h4>
            <span class="account-type">{{ account.accountType }}</span>
          </div>
          <div v-if="account.isPrimary" class="primary-badge">기본</div>
        </div>
        <div class="account-body">
          <div class="account-number">****-****-{{ account.accountNumber.slice(-4) }}</div>
          <div class="account-balance">₩{{ account.balance.toLocaleString() }}</div>
        </div>
        <div class="account-footer">
          <div class="account-details">
            <div class="detail-item">
              <span class="detail-label">이자율</span>
              <span class="detail-value">{{ account.interestRate }}%</span>
            </div>
          </div>
          <RouterLink :to="`/banks/${account.id}`" class="view-details">
            상세보기
            <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
            </svg>
          </RouterLink>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.banks-page {
  max-width: 1200px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.card {
  background: white;
  padding: 24px;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  margin-bottom: 24px;
}

.total-balance-card {
  background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
  color: white;
}

.total-balance-card .card-title {
  color: white;
  margin-bottom: 16px;
}

.total-balance {
  font-size: 2.5rem;
  font-weight: 700;
}

.accounts-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 16px;
}

.account-card {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  transition: transform 0.2s;
}

.account-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.account-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 16px;
}

.bank-name {
  font-size: 1.125rem;
  font-weight: 600;
  color: var(--text-primary);
}

.account-type {
  font-size: 0.75rem;
  color: var(--text-secondary);
  text-transform: uppercase;
}

.primary-badge {
  padding: 2px 8px;
  background: var(--success-color);
  color: white;
  border-radius: 4px;
  font-size: 0.75rem;
  font-weight: 600;
}

.account-body {
  margin-bottom: 16px;
}

.account-number {
  font-size: 0.875rem;
  color: var(--text-secondary);
  margin-bottom: 8px;
}

.account-balance {
  font-size: 1.75rem;
  font-weight: 700;
  color: var(--text-primary);
}

.account-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 16px;
  border-top: 1px solid var(--border-color);
}

.view-details {
  display: flex;
  align-items: center;
  gap: 4px;
  color: var(--primary-color);
  text-decoration: none;
  font-size: 0.875rem;
  font-weight: 500;
}

.view-details .icon {
  width: 16px;
  height: 16px;
}
</style>
