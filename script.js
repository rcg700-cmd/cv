// Menú móvil
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

  // Cierra el menú móvil al hacer clic en un enlace
  if (navlinks) {
    navlinks.querySelectorAll('a').forEach(function (a) {
      a.addEventListener('click', closeMenu);
    });
  }

})();
