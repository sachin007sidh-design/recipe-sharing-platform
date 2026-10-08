/* RecipeShare - site-wide behaviour (Phase F): dark mode, scroll animations, back-to-top */
(function () {
  var root = document.documentElement;

  /* ---------- Dark mode toggle (choice is remembered in localStorage) ---------- */
  var themeBtn = document.getElementById('themeToggle');

  function isDark() { return root.getAttribute('data-bs-theme') === 'dark'; }

  function syncThemeIcon() {
    if (!themeBtn) return;
    themeBtn.innerHTML = isDark() ? '<i class="bi bi-sun-fill"></i>' : '<i class="bi bi-moon-stars-fill"></i>';
    themeBtn.setAttribute('aria-pressed', isDark());
    themeBtn.title = isDark() ? 'Switch to light mode' : 'Switch to dark mode';
  }

  if (themeBtn) {
    themeBtn.addEventListener('click', function () {
      var next = isDark() ? 'light' : 'dark';
      root.setAttribute('data-bs-theme', next);
      try { localStorage.setItem('theme', next); } catch (e) { /* storage blocked: ignore */ }
      syncThemeIcon();
      document.dispatchEvent(new Event('themechange')); // lets charts redraw in the new colours
    });
    syncThemeIcon();
  }

  /* ---------- Navbar shadow + back-to-top button ---------- */
  var nav = document.querySelector('.site-nav');
  var toTop = document.createElement('button');
  toTop.className = 'to-top';
  toTop.type = 'button';
  toTop.setAttribute('aria-label', 'Back to top');
  toTop.innerHTML = '<i class="bi bi-arrow-up"></i>';
  document.body.appendChild(toTop);
  toTop.addEventListener('click', function () { window.scrollTo({ top: 0, behavior: 'smooth' }); });

  function onScroll() {
    var y = window.scrollY || document.documentElement.scrollTop;
    if (nav) nav.classList.toggle('scrolled', y > 10);
    toTop.classList.toggle('show', y > 500);
  }
  window.addEventListener('scroll', onScroll, { passive: true });
  onScroll();

  /* ---------- Scroll reveal: fade + slide elements in as they appear ---------- */
  var reduceMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  if (reduceMotion || !('IntersectionObserver' in window)) return;

  var targets = document.querySelectorAll(
    '.recipe-card, .category-tile, .step-card, .stat-card, .stat-strip, .cta-band, ' +
    '.section-title, .empty-state, .auth-split, .detail-hero, .dash-sidebar'
  );

  var observer = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (!entry.isIntersecting) return;
      var el = entry.target;
      el.classList.add('in');
      observer.unobserve(el);
      // Remove the helper classes afterwards so hover effects work normally again
      var delay = parseInt(el.style.getPropertyValue('--d'), 10) || 0;
      setTimeout(function () { el.classList.remove('reveal', 'in'); el.style.removeProperty('--d'); }, 900 + delay);
    });
  }, { threshold: 0.1, rootMargin: '0px 0px -30px 0px' });

  targets.forEach(function (el) {
    // Stagger items that sit side by side (cards in the same grid row/container)
    var wrapper = el.closest('[class*="col-"]');
    var container = wrapper ? wrapper.parentElement : el.parentElement;
    var index = container ? Array.prototype.indexOf.call(container.children, wrapper || el) : 0;
    el.style.setProperty('--d', Math.min(Math.max(index, 0), 6) * 80 + 'ms');
    el.classList.add('reveal');
    observer.observe(el);
  });
})();
