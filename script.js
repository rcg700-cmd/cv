(function () {
  var menuBtn = document.getElementById('menuBtn');
  var navlinks = document.querySelector('.navlinks');

  function closeMenu() {
    if (!navlinks) return;
    navlinks.classList.remove('open');
    if (menuBtn) menuBtn.setAttribute('aria-expanded', 'false');
  }

  if (menuBtn && navlinks) {
    menuBtn.addEventListener('click', function () {
      var open = navlinks.classList.toggle('open');
      menuBtn.setAttribute('aria-expanded', open ? 'true' : 'false');
    });
  }

  if (navlinks) {
    navlinks.querySelectorAll('a').forEach(function (a) {
      a.addEventListener('click', closeMenu);
    });
  }

  // Scroll reveal con IntersectionObserver + stagger
  if ('IntersectionObserver' in window) {
    var reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    if (!reduce) {
      var reveals = Array.prototype.slice.call(document.querySelectorAll('.reveal'));
      reveals.forEach(function (el, idx) {
        if (el.hasAttribute('data-index') && el.getAttribute('data-index') === 'auto') {
          el.style.setProperty('--index', idx % 12);
        }
        el.style.transitionDelay = 'calc(var(--index, 0) * 80ms)';
      });
      var observer = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add('in-view');
            observer.unobserve(entry.target);
          }
        });
      }, { threshold: 0.08, rootMargin: '0px 0px -40px 0px' });
      reveals.forEach(function (el) { observer.observe(el); });
    } else {
      document.querySelectorAll('.reveal').forEach(function (el) {
        el.classList.add('in-view');
      });
    }
  } else {
    document.querySelectorAll('.reveal').forEach(function (el) {
      el.classList.add('in-view');
    });
  }
})();