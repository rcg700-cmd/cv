# AGENTS.md — Página de Curriculum

## Visión general

Portafolio/CV personal estático de **Randall Castillo Guillén** (Analista de Datos & Desarrollador de Software, Alajuela, Costa Rica). Una sola página (`index.html`) sin frameworks, sin bundler y sin dependencias: HTML + CSS + JavaScript vanilla que se sirve tal cual.

- **Idioma del contenido**: español de Costa Rica (`lang="es"`, `og:locale` = `es_CR`). Todo el texto visible al usuario va en español.
- **Sin build**: no hay `package.json` ni paso de compilación. Los cambios son editar → recargar en el navegador.
- **Despliegue**: servido desde `lab-linux` vía Tailscale Funnel en `https://lab-linux.tailf228f3.ts.net:8443/cv/`. El host puede cambiar; si cambia, actualizar la URL canónica, `og:url`, `og:image` y `twitter:image` en `index.html`.

## Estructura de archivos

| Archivo | Rol |
| --- | --- |
| `index.html` | Única página real: nav, hero, y secciones `#resumen`, `#experiencia`, `#logros`, `#educacion`, `#habilidades`, `#contacto` + footer |
| `styles.css` | Todo el estilo. Tema oscuro con variables CSS en `:root` (fondo `#0b1220`, texto `#e8ecf4`, acento verde `#66BB6A`) |
| `script.js` | JS mínimo en IIFE: solo el toggle del menú móvil (`#menuBtn` ↔ `.navlinks.open`) y cierre al hacer clic en un enlace |
| `favicon.svg` | Ícono del sitio |
| `profile.jpg` | Foto de perfil; se referencia con `?v=N` para romper caché |
| `logos.html`, `logos2.html` | Borradores descartables de opciones de logo (páginas independientes con CSS inline, NO enlazadas desde `index.html`). Son material de trabajo, no parte del sitio público |
| `README.md` | Mínimo (`# cv`); mejorar solo si se pide |

## Convenciones

- **HTML semántico**: cada bloque de contenido es un `<section id="...">` dentro de `.container`. Los IDs de sección son el ancla de la navegación; no renombrarlos sin actualizar los `href` del nav.
- **CSS**: mantener el patrón actual — selectores compactos en una línea, colores SOLO vía las variables de `:root` (verde `#66BB6A` como acento). No hardcodear colores nuevos en reglas sueltas.
- **Responsive**: breakpoints en `@media (max-width:820px)` y `(max-width:480px)`. Cualquier cambio de layout debe probarse en ambos.
- **JS**: vanilla puro, sin librerías. Mantenerlo en IIFE para no declarar globales. No introducir frameworks ni CDNs sin pedirlo explícitamente.
- **Accesibilidad**: preservar los `aria-label`, `alt` de imágenes y `rel="noopener noreferrer"` en enlaces externos.

## Reglas al editar

- **SEO**: si cambia título, descripción o la foto, mantener sincronizados `<title>`, `meta description`, `canonical`, Open Graph (`og:*`) y Twitter Cards (`twitter:*`).
- **Caché de imagen**: al reemplazar `profile.jpg`, incrementar el `?v=N` en su `src`.
- **Datos personales**: nombre, correos, LinkedIn, GitHub y métricas de logros viven en `index.html`; verificar con el dueño antes de alterarlos.
- **No borrar** `logos.html`/`logos2.html` sin confirmación; son borradores de diseño del dueño.
- **Nunca** agregar `node_modules/`, bundlers o dependencias a menos que se pida.

## Git

Repositorio Git presente.

**Flujo de trabajo con ramas:**
- `production`: rama que refleja lo que está desplegado en producción (`https://lab-linux.tailf228f3.ts.net:8443/cv/`). **Nunca** trabajar directamente aquí.
- `developer`: rama de desarrollo. **Siempre** trabajar aquí para cualquier cambio o mejora. Hacer commits claros en español.

Usar mensajes de commit claros en español, por ejemplo: `feat: agrega sección de certificaciones` o `fix: corrige menú móvil en iOS`.

**Regla de despliegue:**
- NO subir a `production` ni a línea sin autorización explícita del usuario.
- Para subir a producción: merge de `developer` → `production`, luego sincronizar archivos a `/home/randall/cv-web/` en `lab-linux` (contenedor `cv-web` monta esa carpeta en modo lectura).
