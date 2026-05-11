<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { RouterLink } from 'vue-router';
import { useDashboardStore } from '../stores/dashboard';

const dashboardStore = useDashboardStore();
const loading = ref(true);

onMounted(async () => {
  // Fetch portfolio data
  loading.value = false;
});
</script>

<template>
  <div class="dashboard">
    <h1 class="page-title">대시보드</h1>

    <!-- Total Value Card -->
    <div class="card total-value-card">
      <div class="card-header">
        <h3>총 자산</h3>
        <span class="period-selector">
          <button class="period-btn active">1M</button>
          <button class="period-btn">3M</button>
          <button class="period-btn">6M</button>
          <button class="period-btn">1Y</button>
        </span>
      </div>
      <div class="card-body">
        <div class="total-value">
          <span class="amount">₩{{ dashboardStore.totalValue.toLocaleString() }}</span>
          <span class="profit" v-if="dashboardStore.totalProfit > 0">
            +{{ dashboardStore.totalProfit.toLocaleString() }} (+{{ (dashboardStore.totalProfit / dashboardStore.totalValue * 100).toFixed(2) }}%)
          </span>
          <span class="profit negative" v-else-if="dashboardStore.totalProfit < 0">
            {{ dashboardStore.totalProfit.toLocaleString() }} ({{ (dashboardStore.totalProfit / dashboardStore.totalValue * 100).toFixed(2) }}%)
          </span>
        </div>
      </div>
    </div>

    <!-- Asset Allocation -->
    <div class="card">
      <h3 class="card-title">자산 분포</h3>
      <div class="allocation-chart">
        <div v-for="(percentage, type) in dashboardStore.assetAllocation" :key="type" class="allocation-item">
          <div class="allocation-label">{{ type }}</div>
          <div class="allocation-bar">
            <div class="allocation-fill" :style="{ width: percentage + '%' }"></div>
          </div>
          <div class="allocation-value">{{ percentage.toFixed(1) }}%</div>
        </div>
      </div>
    </div>

    <!-- Quick Actions -->
    <div class="card">
      <h3 class="card-title">빠른 액션</h3>
      <div class="quick-actions">
        <RouterLink to="/stocks" class="action-btn">
          <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
          </svg>
          <span>주식 추가</span>
        </RouterLink>
        <RouterLink to="/banks" class="action-btn">
          <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
          </svg>
          <span>계좌 추가</span>
        </RouterLink>
        <RouterLink to="/real-estates" class="action-btn">
          <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
          </svg>
          <span>부동산 추가</span>
        </RouterLink>
      </div>
    </div>

    <!-- Top Assets -->
    <div class="card">
      <h3 class="card-title">주요 자산</h3>
      <div class="asset-list">
        <div v-for="asset in dashboardStore.topGainers" :key="asset.id" class="asset-item">
          <div class="asset-info">
            <span class="asset-name">{{ asset.name }}</span>
            <span class="asset-type">{{ asset.type }}</span>
          </div>
          <div class="asset-value">
            <div class="value">{{ asset.value.toLocaleString() }}</div>
            <div :class="['profit', asset.profit >= 0 ? 'positive' : 'negative']">
              {{ asset.profit >= 0 ? '+' : '' }}{{ asset.profit.toLocaleString() }} ({{ asset.profitRate.toFixed(2) }}%)
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.dashboard {
  max-width: 1200px;
}

.page-title {
  font-size: 1.5rem;
  font-weight: 600;
  margin-bottom: 24px;
}

.card {
  background: white;
  border-radius: 12px;
  padding: 24px;
  margin-bottom: 24px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.period-selector {
  display: flex;
  gap: 4px;
}

.period-btn {
  padding: 4px 12px;
  border: none;
  background: var(--bg-color);
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.875rem;
  color: var(--text-secondary);
}

.period-btn.active {
  background: var(--primary-color);
  color: white;
}

.total-value-card .card-body {
  padding: 20px 0;
}

.total-value .amount {
  font-size: 2.5rem;
  font-weight: 700;
  color: var(--text-primary);
}

.total-value .profit {
  margin-left: 16px;
  font-size: 1.125rem;
  color: var(--success-color);
}

.total-value .profit.negative {
  color: var(--danger-color);
}

.allocation-chart {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.allocation-item {
  display: flex;
  align-items: center;
  gap: 12px;
}

.allocation-label {
  width: 80px;
  font-size: 0.875rem;
  color: var(--text-secondary);
}

.allocation-bar {
  flex: 1;
  height: 8px;
  background: var(--bg-color);
  border-radius: 4px;
  overflow: hidden;
}

.allocation-fill {
  height: 100%;
  background: var(--primary-color);
  border-radius: 4px;
}

.allocation-value {
  width: 50px;
  text-align: right;
  font-size: 0.875rem;
  font-weight: 600;
}

.card-title {
  font-size: 1.125rem;
  font-weight: 600;
  margin-bottom: 16px;
  color: var(--text-primary);
}

.quick-actions {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 16px;
}

.action-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 24px;
  background: var(--bg-color);
  border-radius: 8px;
  text-decoration: none;
  color: var(--text-primary);
  transition: all 0.2s;
}

.action-btn:hover {
  background: var(--primary-color);
  color: white;
}

.action-btn .icon {
  width: 32px;
  height: 32px;
  margin-bottom: 8px;
}

.asset-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.asset-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: var(--bg-color);
  border-radius: 8px;
}

.asset-info {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.asset-name {
  font-weight: 600;
  font-size: 0.9375rem;
}

.asset-type {
  font-size: 0.75rem;
  color: var(--text-secondary);
  text-transform: capitalize;
}

.asset-value {
  text-align: right;
}

.asset-value .value {
  font-weight: 600;
  font-size: 0.9375rem;
}

.profit.positive {
  color: var(--success-color);
}

.profit.negative {
  color: var(--danger-color);
}
</style>
