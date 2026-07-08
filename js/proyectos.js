const tagMap = {
  agro:  { label: 'Agroecología',  cls: 'tag-agro'  },
  arte:  { label: 'Arte y Cultura', cls: 'tag-arte'  },
  comun: { label: 'Comunidad',      cls: 'tag-comun' }
};

const categoryStyles = {
  agro: { badgeCls: 'badge-green', tagCls: 'tag-agro', label: 'Agroecología' },
  arte: { badgeCls: 'badge-red', tagCls: 'tag-arte', label: 'Arte y Cultura' },
  comun: { badgeCls: 'badge-green', tagCls: 'tag-comun', label: 'Comunidad' }
};

function mapDBCategory(categoriaNombre) {
  if (!categoriaNombre) return 'comun';
  const clean = categoriaNombre.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
  if (clean.includes('agro')) return 'agro';
  if (clean.includes('arte')) return 'arte';
  if (clean.includes('comun')) return 'comun';
  return 'comun';
}

const hamburger  = document.getElementById('hamburger');
const mobileMenu = document.getElementById('mobile-menu');

hamburger.addEventListener('click', () => {
  hamburger.classList.toggle('open');
  mobileMenu.classList.toggle('open');
});

document.querySelectorAll('.filter-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');

    const filter = btn.dataset.filter;

    document.querySelectorAll('.card').forEach(card => {
      const match = filter === 'all' || card.dataset.category === filter;
      card.style.display    = match ? '' : 'none';
      card.style.animation  = match ? 'fadeIn .35s ease' : '';
    });
  });
});

const overlay    = document.getElementById('modal-overlay');
const modalImg   = document.getElementById('modal-img');
const modalTitle = document.getElementById('modal-title');
const modalDesc  = document.getElementById('modal-desc');
const modalTag   = document.getElementById('modal-tag');

function openModal(card) {
  const tag = tagMap[card.dataset.tag] || { label: '', cls: '' };

  modalImg.src            = card.dataset.img;
  modalImg.alt            = card.dataset.title;
  modalTitle.textContent  = card.dataset.title;
  modalDesc.textContent   = card.dataset.desc;
  modalTag.textContent    = tag.label;
  modalTag.className      = 'modal-tag ' + tag.cls;

  overlay.classList.add('open');
}

function closeModal() {
  overlay.classList.remove('open');
}

document.getElementById('modal-close').addEventListener('click', closeModal);

overlay.addEventListener('click', e => {
  if (e.target === overlay) closeModal();
});

document.addEventListener('keydown', e => {
  if (e.key === 'Escape') closeModal();
});

// Carga dinámica de proyectos con fallback
async function cargarProyectos() {
  try {
    const res = await fetch('../backend/api/proyectos.php');
    if (res.ok) {
      const proyectos = await res.json();
      if (Array.isArray(proyectos) && proyectos.length > 0) {
        const grid = document.getElementById('cards-grid');
        if (grid) {
          grid.innerHTML = ''; // Vaciar estáticos
          proyectos.forEach(p => {
            const catKey = mapDBCategory(p.categoria);
            const style = categoryStyles[catKey];
            
            const card = document.createElement('div');
            card.className = 'card';
            card.setAttribute('data-category', catKey);
            card.setAttribute('data-tag', catKey);
            card.setAttribute('data-title', p.titulo);
            card.setAttribute('data-img', p.url_imagen || 'https://images.unsplash.com/photo-1530836369250-ef72a3f5cda8?w=600&q=70');
            card.setAttribute('data-desc', p.descripcion_completa || p.resumen);
            
            card.innerHTML = `
              <div class="card-img-wrap">
                <img class="card-img" src="${p.url_imagen || 'https://images.unsplash.com/photo-1530836369250-ef72a3f5cda8?w=600&q=70'}" alt="${p.titulo}" />
                <div class="card-badge ${style.badgeCls}" aria-hidden="true">
                  <img class="leaf2" src="../src/img/leaf.png" alt="" aria-hidden="true" />
                </div>
              </div>
              <div class="card-body">
                <span class="card-tag ${style.tagCls}">${style.label}</span>
                <h3>${p.titulo}</h3>
                <p>${p.resumen}</p>
                <a class="card-link" href="#">Ver mas</a>
              </div>
            `;
            
            card.addEventListener('click', () => openModal(card));
            grid.appendChild(card);
          });
          return; // Finalizar con éxito
        }
      }
    }
  } catch (e) {
    console.error('Error al cargar proyectos desde API, usando estáticos de fallback:', e);
  }

  // Fallback: Enlazar modal a las tarjetas estáticas preexistentes si la API falló
  document.querySelectorAll('.card').forEach(card => {
    card.addEventListener('click', () => openModal(card));
  });
}

async function cargarConfiguracionFooter() {
  try {
    const res = await fetch('../backend/api/config.php');
    if (res.ok) {
      const config = await res.json();
      if (config && Object.keys(config).length > 0) {
        const footerInfo = document.querySelector('.footer-info p');
        if (footerInfo) {
          footerInfo.innerHTML = `
            ${config.nombre_escuela || 'Aula Satélite "Educación para las Primaveras"'}<br>
            CUE: ${config.cue || '5400697/02'}<br>
            ${config.direccion || 'Ruta Provincial 15 km.16 Paraje San Ramón, Colonia Primavera, El Soberbio, Misiones'}<br>
            E-mail: <a href="mailto:${config.correo_contacto || 'martincorneli@hotmail.com'}">${config.correo_contacto || 'martincorneli@hotmail.com'}</a>
          `;
        }
      }
    }
  } catch (e) {
    console.error('Error al cargar config para el footer:', e);
  }
}

// Ejecutar carga al estar listo el DOM
document.addEventListener('DOMContentLoaded', () => {
  cargarProyectos();
  cargarConfiguracionFooter();
});
