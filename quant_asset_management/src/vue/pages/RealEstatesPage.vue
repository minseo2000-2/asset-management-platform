<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';

interface RealEstate {
  id: number;
  propertyType: string;
  name: string;
  address: string;
  areaSqM: number;
  marketValue: number;
  loanRemaining: number;
  equity: number;
  rentIncome: number;
}

const properties = ref<RealEstate[]>([]);
const totalValue = computed(() => properties.value.reduce((sum, p) => sum + p.marketValue, 0));
const totalLoan = computed(() => properties.value.reduce((sum, p) => sum + p.loanRemaining, 0));
const totalEquity = computed(() => totalValue.value - totalLoan.value);

const loadProperties = async () => {
  // API call to fetch properties
};

onMounted(loadProperties);
</script>

<template>
  <div class="realestate-page">
    <div class="page-header">
      <h1 class="page-title">부동산 자산</h1>
      <button class="btn-primary" @click="showDialog = true">
        <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
        </svg>
        부동산 추가
      </button>
    </div>

    <!-- Summary Cards -->
    <div class="summary-cards">
      <div class="summary-card">
        <div class="summary-label">총 자산가치</div>
        <div class="summary-value">₩{{ totalValue.toLocaleString() }}</div>
      </div>
      <div class="summary-card">
        <div class="summary-label">총 대출금</div>
        <div class="summary-value">₩{{ totalLoan.toLocaleString() }}</div>
      </div>
      <div class="summary-card">
        <div class="summary-label">자기자본</div>
        <div class="summary-value positive">₩{{ totalEquity.toLocaleString() }}</div>
      </div>
    </div>

    <!-- Property List -->
    <div class="properties-grid">
      <div v-for="property in properties" :key="property.id" class="property-card">
        <div class="property-header">
          <div class="property-type-badge">{{ property.propertyType }}</div>
          <div class="property-price">₩{{ property.marketValue.toLocaleString() }}</div>
        </div>
        <h3 class="property-name">{{ property.name }}</h3>
        <p class="property-address">{{ property.address }}</p>
        <div class="property-details">
          <div class="detail-item">
            <span class="label">면적</span>
            <span class="value">{{ property.areaSqM }}m² ({{ (property.areaSqM * 0.3025).toFixed(1) }}평)</span>
          </div>
          <div class="detail-item">
            <span class="label">대출 잔액</span>
            <span class="value">₩{{ property.loanRemaining.toLocaleString() }}</span>
          </div>
          <div class="detail-item">
            <span class="label">자기자본</span>
            <span class="value positive">₩{{ property.equity.toLocaleString() }}</span>
          </div>
          <div class="detail-item">
            <span class="label">월 임대수입</span>
            <span class="value">₩{{ property.rentIncome.toLocaleString() }}</span>
          </div>
        </div>
        <div class="property-actions">
          <button class="btn-secondary">상세정보</button>
          <button class="btn-secondary">수정</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.realestate-page {
  max-width: 1200px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
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

.properties-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 20px;
}

.property-card {
  background: white;
  border-radius: 12px;
  padding: 24px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.property-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.property-type-badge {
  padding: 4px 12px;
  background: var(--bg-color);
  border-radius: 4px;
  font-size: 0.75rem;
  font-weight: 600;
  color: var(--text-secondary);
  text-transform: uppercase;
}

.property-price {
  font-size: 1.25rem;
  font-weight: 700;
  color: var(--text-primary);
}

.property-name {
  font-size: 1.125rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 8px;
}

.property-address {
  font-size: 0.875rem;
  color: var(--text-secondary);
  margin-bottom: 16px;
}

.property-details {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
  margin-bottom: 16px;
}

.detail-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.detail-item .label {
  font-size: 0.75rem;
  color: var(--text-secondary);
}

.detail-item .value {
  font-size: 0.875rem;
  font-weight: 500;
  color: var(--text-primary);
}

.detail-item .value.positive {
  color: var(--success-color);
}

.property-actions {
  display: flex;
  gap: 8px;
}

.btn-secondary {
  flex: 1;
  padding: 10px;
  background: var(--bg-color);
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 0.875rem;
  color: var(--text-primary);
  transition: background 0.2s;
}

.btn-secondary:hover {
  background: var(--border-color);
}
</style>
