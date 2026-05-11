import { defineStore } from 'pinia';
import { ref, computed } from 'vue';

interface Asset {
  id: number;
  type: string;
  name: string;
  value: number;
  profit: number;
  profitRate: number;
}

export const useDashboardStore = defineStore('dashboard', () => {
  const totalValue = ref(0);
  const totalProfit = ref(0);
  const assets = ref<Asset[]>([]);

  const assetAllocation = computed(() => {
    const allocation: Record<string, number> = {};
    assets.value.forEach(asset => {
      if (!allocation[asset.type]) {
        allocation[asset.type] = 0;
      }
      allocation[asset.type] += asset.value;
    });

    Object.keys(allocation).forEach(key => {
      allocation[key] = (allocation[key] / totalValue.value) * 100;
    });

    return allocation;
  });

  const topGainers = computed(() => {
    return [...assets.value].sort((a, b) => b.profitRate - a.profitRate).slice(0, 5);
  });

  const updateValue = (assetsList: Asset[]) => {
    assets.value = assetsList;
    totalValue.value = assetsList.reduce((sum, asset) => sum + asset.value, 0);
    totalProfit.value = assetsList.reduce((sum, asset) => sum + asset.profit, 0);
  };

  return {
    totalValue,
    totalProfit,
    assets,
    assetAllocation,
    topGainers,
    updateValue,
  };
});
