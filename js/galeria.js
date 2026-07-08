/**
 * galeria.js — Filtro de categorías para la galería con soporte dinámico
 */

document.addEventListener('DOMContentLoaded', function () {
    const filterButtons = document.querySelectorAll('.filtro-btn');

    function mapDBCategory(categoriaNombre) {
        if (!categoriaNombre) return 'comunidad';
        const clean = categoriaNombre.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
        if (clean.includes('escuela')) return 'escuela';
        if (clean.includes('huerta')) return 'huerta';
        if (clean.includes('arte')) return 'arte';
        if (clean.includes('comunidad')) return 'comunidad';
        if (clean.includes('evento')) return 'eventos';
        return 'comunidad';
    }

    // Configuración de los botones de filtro
    filterButtons.forEach(function (btn) {
        btn.addEventListener('click', function () {
            // Actualizar botón activo
            filterButtons.forEach(function (b) { b.classList.remove('active'); });
            btn.classList.add('active');

            const filter = btn.getAttribute('data-filter');
            const currentFotoItems = document.querySelectorAll('.foto-item'); // Selector dinámico para evitar elementos huérfanos

            currentFotoItems.forEach(function (item) {
                if (filter === 'todo' || item.getAttribute('data-category') === filter) {
                    item.classList.remove('hidden');
                } else {
                    item.classList.add('hidden');
                }
            });
        });
    });

    // Carga dinámica de imágenes desde la base de datos
    async function cargarGaleria() {
        try {
            const res = await fetch('../backend/api/galeria.php');
            if (res.ok) {
                const fotos = await res.json();
                if (Array.isArray(fotos) && fotos.length > 0) {
                    const grid = document.getElementById('foto-grid');
                    if (grid) {
                        grid.innerHTML = ''; // Vaciar estáticos
                        fotos.forEach(f => {
                            const catKey = mapDBCategory(f.categoria);
                            const item = document.createElement('div');
                            item.className = 'foto-item';
                            item.setAttribute('data-category', catKey);

                            const img = document.createElement('img');
                            img.src = f.url_imagen;
                            img.alt = f.texto_alternativo || f.titulo;

                            item.appendChild(img);
                            grid.appendChild(item);
                        });
                    }
                }
            }
        } catch (e) {
            console.error('Error al cargar la galería desde la API, usando estáticos de fallback:', e);
        }
    }

    async function cargarConfiguracionFooter() {
        try {
            const res = await fetch('../backend/api/config.php');
            if (res.ok) {
                const config = await res.json();
                if (config && Object.keys(config).length > 0) {
                    const footerInfo = document.querySelector('.footer-info');
                    if (footerInfo) {
                        let dirLine1 = 'Ruta Provincial 15 km.16 Paraje San Ramón';
                        let dirLine2 = 'Colonia Primavera, El Soberbio, Misiones';
                        if (config.direccion) {
                            const parts = config.direccion.split(', ');
                            if (parts.length >= 2) {
                                dirLine1 = parts[0];
                                dirLine2 = parts.slice(1).join(', ');
                            } else {
                                dirLine1 = config.direccion;
                                dirLine2 = '';
                            }
                        }
                        footerInfo.innerHTML = `
                            <p>${config.nombre_escuela || 'Aula Satélite "Educación para las Primaveras"'}</p>
                            <p>CUE: ${config.cue || '5400697/02'}</p>
                            <p>${dirLine1}</p>
                            ${dirLine2 ? `<p>${dirLine2}</p>` : ''}
                            <p>E-mail: <a href="mailto:${config.correo_contacto || 'martincorneil@hotmail.com'}">${config.correo_contacto || 'martincorneil@hotmail.com'}</a></p>
                        `;
                    }
                }
            }
        } catch (e) {
            console.error('Error al cargar config para el footer:', e);
        }
    }

    // Ejecutar carga dinámica y footer
    cargarGaleria();
    cargarConfiguracionFooter();
});
