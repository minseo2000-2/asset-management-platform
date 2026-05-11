<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { RouterLink } from 'vue-router';

interface Stock {
  id: number;
  ticker: string;
  name: string;
  quantity: number;
  avgPrice: number;
  currentPrice: number;
  totalValue: number;
  profit: number;
  profitRate: number;
  market: string;
}

const stocks = ref<Stock[]>([]);
const showDialog = ref(false);
const newStock = ref({
  ticker: '',
  name: '',
  quantity: 0,
  avgPrice: 0,
  market: 'KOSPI',
});

const filteredStocks = computed(() => stocks.value);

const loadStocks = async () => {
  // API call to fetch stocks
};

const addStock = async () => {
  // API call to add stock
  showDialog.value = false;
  loadStocks();
};

onMounted(loadStocks);
</script>

<template>
  <div class="stocks-page">
    <div class="page-header">
      <h1 class="page-title">주식 투자</h1>
      <button class="btn-primary" @click="showDialog = true">
        <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
        </svg>
        주식 추가
      </button>
    </div>

    <!-- Summary Cards -->
    <div class="summary-cards">
      <div class="summary-card">
        <div class="summary-label">총 투자액</div>
        <div class="summary-value">₩{{ stocks.reduce((sum, s) => sum + s.totalValue, 0).toLocaleString() }}</div>
      </div>
      <div class="summary-card">
        <div class="summary-label">평가 손익</div>
        <div class="summary-value" :class="{ positive: stocks.reduce((sum, s) => sum + s.profit, 0) >= 0 }">
          ₩{{ stocks.reduce((sum, s) => sum + s.profit, 0).toLocaleString() }}
        </div>
      </div>
      <div class="summary-card">
        <div class="summary-label">수익률</div>
        <div class="summary-value" :class="{ positive: true }">
          {{ (stocks.reduce((sum, s) => sum + s.profit, 0) / stocks.reduce((sum, s) => sum + s.totalValue, 0) * 100).toFixed(2) }}%
        </div>
      </div>
    </div>

    <!-- Stock Table -->
    <div class="stock-table-container">
      <table class="stock-table">
        <thead>
          <tr>
            <th>티커</th>
            <th>이름</th>
            <th>수량</th>
            <th>평단가</th>
            <th>현재가</th>
            <th>총액</th>
            <th>손익</th>
            <th>수익률</th>
            <th>시장</th>
            <th>작업</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="stock in filteredStocks" :key="stock.id">
            <td>
              <RouterLink :to="`/stocks/${stock.ticker}`" class="ticker-link">
                {{ stock.ticker }}
              </RouterLink>
            </td>
            <td>{{ stock.name }}</td>
            <td>{{ stock.quantity }}</td>
            <td>₩{{ stock.avgPrice.toLocaleString() }}</td>
            <td>₩{{ stock.currentPrice.toLocaleString() }}</td>
            <td>₩{{ stock.totalValue.toLocaleString() }}</td>
            <td :class="{ positive: stock.profit >= 0 }">
              {{ stock.profit >= 0 ? '+' : '' }}₩{{ stock.profit.toLocaleString() }}
            </td>
            <td :class="{ positive: stock.profitRate >= 0 }">
              {{ stock.profitRate.toFixed(2) }}%
            </td>
            <td>
              <span class="market-badge">{{ stock.market }}</span>
            </td>
            <td>
              <button class="btn-icon" title="수정">
                <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                </svg>
              </button>
              <button class="btn-icon" title="삭제">
                <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                </svg>
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<style scoped>
.stocks-page {
  max-width: 1200px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.page-title {
  font-size: 1.5rem;
  font-weight: 600;
  color: var(--text-primary);
}

.btn-primary {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 20px;
  background: var(--primary-color);
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 0.9375rem;
}

.btn-primary .icon {
  width: 20px;
  height: 20px;
}

.summary-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 16px;
  margin-bottom: 24px;
}

.summary-card {
  background: white;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.summary-label {
  font-size: 0.875rem;
  color: var(--text-secondary);
  margin-bottom: 8px;
}

.summary-value {
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--text-primary);
}

.summary-value.positive {
  color: var(--success-color);
}

.stock-table-container {
  background: white;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.stock-table {
  width: 100%;
  border-collapse: collapse;
}

.stock-table thead {
  background: var(--bg-color);
}

.stock-table th {
  padding: 12px 16px;
  text-align: left;
  font-size: 0.75rem;
  font-weight: 600;
  color: var(--text-secondary);
  text-transform: uppercase;
}

.stock-table td {
  padding: 12px 16px;
  border-bottom: 1px solid var(--border-color);
  font-size: 0.875rem;
}

.stock-table tr:last-child td {
  border-bottom: none;
}

.ticker-link {
  color: var(--primary-color);
  text-decoration: none;
  font-weight: 600;
}

.market-badge {
  display: inline-block;
  padding: 2px 8px;
  background: var(--bg-color);
  border-radius: 4px;
  font-size: 0.75rem;
  font-weight: 600;
  color: var(--text-secondary);
}

.btn-icon {
  background: none;
  border: none;
  cursor: pointer;
  padding: 4px;
  margin-left: 4px;
  color: var(--text-secondary);
}

.btn-icon:hover {
  color: var(--primary-color);
}

.profit.positive {
  color: var(--success-color);
}
</style>
