// Toggle del menú móvil
(function () {
  var menuBtn = document.getElementById('menuBtn');
  var navlinks = document.querySelector('.navlinks');
  if (menuBtn && navlinks) {
    menuBtn.addEventListener('click', function () {
      navlinks.classList.toggle('open');
    });
  }
  // Cierra el menú móvil al hacer clic en un enlace
  if (navlinks) {
    navlinks.querySelectorAll('a').forEach(function (a) {
      a.addEventListener('click', function () {
        navlinks.classList.remove('open');
      });
    });
  }
})();
