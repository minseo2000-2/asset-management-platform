<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { RouterLink } from 'vue-router';

interface PortfolioData {
  totalValue: number;
  totalCost: number;
  totalProfit: number;
  totalProfitRate: number;
  dailyProfit: number;
  dailyProfitRate: number;
  allocation: Record<string, number>;
}

const portfolio = ref<PortfolioData>({
  totalValue: 0,
  totalCost: 0,
  totalProfit: 0,
  totalProfitRate: 0,
  dailyProfit: 0,
  dailyProfitRate: 0,
  allocation: {},
});

const loadPortfolio = async () => {
  // API call to fetch portfolio data
};

const getAllocationColor = (type: string) => {
  const colors: Record<string, string> = {
    stock: '#3b82f6',
    bank: '#10b981',
    real_estate: '#f59e0b',
    crypto: '#8b5cf6',
    cash: '#64748b',
  };
  return colors[type] || '#64748b';
};

onMounted(loadPortfolio);
</script>

<template>
  <div class="portfolio-page">
    <h1 class="page-title">포트폴리오 분석</h1>

    <!-- Key Metrics -->
    <div class="metrics-grid">
      <div class="metric-card">
        <div class="metric-label">총 자산가치</div>
        <div class="metric-value">₩{{ portfolio.totalValue.toLocaleString() }}</div>
      </div>
      <div class="metric-card">
        <div class="metric-label">총 투자원금</div>
        <div class="metric-value">₩{{ portfolio.totalCost.toLocaleString() }}</div>
      </div>
      <div class="metric-card">
        <div class="metric-label">총 손익</div>
        <div class="metric-value" :class="{ positive: portfolio.totalProfit >= 0 }">
          {{ portfolio.totalProfit >= 0 ? '+' : '' }}₩{{ portfolio.totalProfit.toLocaleString() }}
        </div>
      </div>
      <div class="metric-card">
        <div class="metric-label">수익률</div>
        <div class="metric-value" :class="{ positive: portfolio.totalProfitRate >= 0 }">
          {{ portfolio.totalProfitRate.toFixed(2) }}%
        </div>
      </div>
    </div>

    <!-- Asset Allocation -->
    <div class="card">
      <h2 class="card-title">자산 배분</h2>
      <div class="allocation-section">
        <div class="allocation-chart">
          <div v-for="(percentage, type) in portfolio.allocation" :key="type" class="allocation-item">
            <div class="allocation-label">{{ type }}</div>
            <div class="allocation-bar">
              <div class="allocation-fill" :style="{ width: percentage + '%', backgroundColor: getAllocationColor(type) }"></div>
            </div>
            <div class="allocation-value">{{ percentage.toFixed(1) }}%</div>
          </div>
        </div>
      </div>
    </div>

    <!-- Asset Breakdown -->
    <div class="card">
      <h2 class="card-title">자산 세부 내역</h2>
      <div class="asset-breakdown">
        <div v-for="(percentage, type) in portfolio.allocation" :key="type" class="asset-row">
          <div class="asset-cell asset-type">
            <span class="color-dot" :style="{ backgroundColor: getAllocationColor(type) }"></span>
            <span class="asset-name">{{ type }}</span>
          </div>
          <div class="asset-cell asset-percentage">
            {{ percentage.toFixed(1) }}%
          </div>
          <div class="asset-cell asset-value">
            ₩{{ (portfolio.totalValue * percentage / 100).toLocaleString() }}
          </div>
          <div class="asset-cell asset-profit">
            <RouterLink :to="`/${type}`" class="view-link">자세히</RouterLink>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.portfolio-page {
  max-width: 1000px;
}

.page-title {
  font-size: 1.5rem;
  font-weight: 600;
  margin-bottom: 24px;
}

.metrics-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 16px;
  margin-bottom: 24px;
}

.metric-card {
  background: white;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.metric-label {
  font-size: 0.875rem;
  color: var(--text-secondary);
  margin-bottom: 8px;
}

.metric-value {
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--text-primary);
}

.metric-value.positive {
  color: var(--success-color);
}

.card {
  background: white;
  border-radius: 12px;
  padding: 24px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  margin-bottom: 24px;
}

.card-title {
  font-size: 1.25rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 20px;
}

.allocation-section {
  padding: 20px;
  background: var(--bg-color);
  border-radius: 8px;
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
  width: 100px;
  font-size: 0.875rem;
  color: var(--text-secondary);
}

.allocation-bar {
  flex: 1;
  height: 10px;
  background: var(--bg-color);
  border-radius: 5px;
  overflow: hidden;
}

.allocation-fill {
  height: 100%;
  border-radius: 5px;
}

.allocation-value {
  width: 60px;
  text-align: right;
  font-weight: 600;
  color: var(--text-primary);
}

.asset-breakdown {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.asset-row {
  display: flex;
  align-items: center;
  padding: 16px;
  background: var(--bg-color);
  border-radius: 8px;
  gap: 16px;
}

.asset-cell {
  flex: 1;
}

.asset-cell.asset-type {
  display: flex;
  align-items: center;
  gap: 10px;
}

.color-dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
}

.asset-name {
  font-weight: 500;
  color: var(--text-primary);
}

.asset-cell.asset-percentage {
  text-align: center;
  font-weight: 500;
}

.asset-cell.asset-value {
  text-align: right;
  font-weight: 600;
}

.asset-cell.asset-profit {
  text-align: right;
}

.view-link {
  color: var(--primary-color);
  text-decoration: none;
  font-size: 0.875rem;
}
</style>
