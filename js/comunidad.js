document.addEventListener('DOMContentLoaded', () => {
    // 1. Cargar Testimonios
    async function cargarTestimonios() {
        try {
            const res = await fetch('../backend/api/testimonios.php');
            if (res.ok) {
                const testimonios = await res.json();
                if (Array.isArray(testimonios) && testimonios.length > 0) {
                    const container = document.querySelector('.center_items');
                    if (container) {
                        container.innerHTML = ''; // Vaciar estáticos
                        testimonios.forEach(t => {
                            const voiceCard = document.createElement('div');
                            voiceCard.className = 'voice';
                            voiceCard.style.padding = '1.5rem';
                            voiceCard.style.textAlign = 'center';
                            voiceCard.style.display = 'flex';
                            voiceCard.style.flexDirection = 'column';
                            voiceCard.style.justifyContent = 'space-between';
                            voiceCard.style.minHeight = '12rem';

                            voiceCard.innerHTML = `
                                <p style="font-style: italic; margin-bottom: 0.8rem; font-size: 0.95rem; line-height: 1.4;">
                                    "${t.contenido}"
                                </p>
                                <cite style="display: block; font-weight: bold; font-style: normal; font-size: 0.85rem; opacity: 0.9; margin-top: auto;">
                                    — ${t.nombre_autor || 'Anónimo'}
                                </cite>
                            `;
                            container.appendChild(voiceCard);
                        });
                    }
                }
            }
        } catch (e) {
            console.error('Error al cargar testimonios:', e);
        }
    }

    // 2. Cargar Configuración del Sitio en el Footer
    async function cargarConfiguracionFooter() {
        try {
            const res = await fetch('../backend/api/config.php');
            if (res.ok) {
                const config = await res.json();
                if (config && Object.keys(config).length > 0) {
                    const footerCols = document.querySelectorAll('footer .col-md-4');
                    if (footerCols.length >= 3) {
                        // Columna 2: Datos de la escuela
                        const col2 = footerCols[1];
                        col2.innerHTML = `
                            <p style="font-weight: bold; margin-bottom: 0.5rem;">
                                ${config.nombre_escuela || 'Escuela Rural N°940'}
                            </p>
                            <p style="font-size: 0.9rem; opacity: 0.9;">
                                CUE: ${config.cue || '5400697/02'}<br>
                                Frase institucional: "${config.frase_institucional || 'Ser cultos para ser libres'}"
                            </p>
                        `;

                        // Columna 3: Contacto
                        const col3 = footerCols[2];
                        col3.innerHTML = `
                            <p style="font-weight: bold; margin-bottom: 0.5rem;">Contacto</p>
                            <p style="font-size: 0.9rem; opacity: 0.9; line-height: 1.6;">
                                Direccion: ${config.direccion || ''}<br>
                                Tel: ${config.telefono || ''}<br>
                                Email: <a href="mailto:${config.correo_contacto || ''}" style="color: inherit; text-decoration: underline;">${config.correo_contacto || ''}</a>
                            </p>
                        `;
                    }
                }
            }
        } catch (e) {
            console.error('Error al cargar la configuración en el footer:', e);
        }
    }

    cargarTestimonios();
    cargarConfiguracionFooter();
});
