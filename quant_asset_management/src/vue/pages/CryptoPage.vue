<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';

interface CryptoAsset {
  id: number;
  coinName: string;
  ticker: string;
  quantity: number;
  avgPrice: number;
  currentPrice: number;
  totalValue: number;
  profit: number;
  profitRate: number;
}

const assets = ref<CryptoAsset[]>([]);
const totalValue = computed(() => assets.value.reduce((sum, a) => sum + a.totalValue, 0));

const loadAssets = async () => {
  // API call to fetch crypto assets
};

onMounted(loadAssets);
</script>

<template>
  <div class="crypto-page">
    <h1 class="page-title">암호화폐 투자</h1>

    <!-- Total Value -->
    <div class="card">
      <h3 class="card-title">총 자산가치</h3>
      <div class="total-value">₩{{ totalValue.toLocaleString() }}</div>
    </div>

    <!-- Assets List -->
    <div class="assets-grid">
      <div v-for="asset in assets" :key="asset.id" class="asset-card">
        <div class="asset-header">
          <div class="coin-info">
            <h4 class="coin-name">{{ asset.coinName }}</h4>
            <span class="coin-ticker">{{ asset.ticker }}</span>
          </div>
          <div class="coin-price">₩{{ asset.currentPrice.toLocaleString() }}</div>
        </div>
        <div class="asset-body">
          <div class="stat-row">
            <span class="label">보유 수량</span>
            <span class="value">{{ asset.quantity }} {{ asset.ticker }}</span>
          </div>
          <div class="stat-row">
            <span class="label">총액</span>
            <span class="value">₩{{ asset.totalValue.toLocaleString() }}</span>
          </div>
          <div class="stat-row">
            <span class="label">수익률</span>
            <span class="value" :class="{ positive: asset.profitRate >= 0 }">
              {{ asset.profitRate.toFixed(2) }}%
            </span>
          </div>
        </div>
        <div class="asset-footer">
          <div class="profit-info">
            <span class="profit-label">손익</span>
            <span class="profit-value" :class="{ positive: asset.profit >= 0 }">
              {{ asset.profit >= 0 ? '+' : '' }}₩{{ asset.profit.toLocaleString() }}
            </span>
          </div>
          <button class="btn-icon" title="거래 내역">
            <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.crypto-page {
  max-width: 1000px;
}

.page-title {
  font-size: 1.5rem;
  font-weight: 600;
  margin-bottom: 24px;
}

.card {
  background: white;
  padding: 24px;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  margin-bottom: 24px;
}

.card-title {
  font-size: 1.125rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 16px;
}

.total-value {
  font-size: 2rem;
  font-weight: 700;
  color: var(--text-primary);
}

.assets-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 16px;
}

.asset-card {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.asset-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.coin-info {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.coin-name {
  font-size: 1.125rem;
  font-weight: 600;
  color: var(--text-primary);
}

.coin-ticker {
  font-size: 0.875rem;
  color: var(--text-secondary);
  text-transform: uppercase;
}

.coin-price {
  font-size: 1.125rem;
  font-weight: 700;
  color: var(--text-primary);
}

.asset-body {
  display: flex;
  flex-direction: column;
  gap: 12px;
  margin-bottom: 16px;
}

.stat-row {
  display: flex;
  justify-content: space-between;
  font-size: 0.875rem;
}

.stat-row .label {
  color: var(--text-secondary);
}

.stat-row .value {
  font-weight: 500;
  color: var(--text-primary);
}

.asset-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 16px;
  border-top: 1px solid var(--border-color);
}

.profit-info {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.profit-value {
  font-weight: 600;
  font-size: 0.9375rem;
}

.profit-value.positive {
  color: var(--success-color);
}

.btn-icon {
  background: none;
  border: none;
  cursor: pointer;
  padding: 8px;
  color: var(--text-secondary);
}
</style>
