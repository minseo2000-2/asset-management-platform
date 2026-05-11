<template>
  <footer class="footer">
    <div class="footer-content">
      <p class="footer-text">Minseo Asset Management Portal v1.0.0</p>
      <div class="footer-links">
        <a href="#" class="footer-link">개인정보처리방침</a>
        <a href="#" class="footer-link">이용약관</a>
        <a href="#" class="footer-link">문의하기</a>
      </div>
    </div>
  </footer>
</template>

<style scoped>
.footer {
  background: white;
  border-top: 1px solid var(--border-color);
  padding: 16px 24px;
  margin-top: auto;
}

.footer-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.footer-text {
  font-size: 0.875rem;
  color: var(--text-secondary);
}

.footer-links {
  display: flex;
  gap: 16px;
}

.footer-link {
  color: var(--text-secondary);
  text-decoration: none;
  font-size: 0.875rem;
}

.footer-link:hover {
  color: var(--primary-color);
}
</style>
