/**
 * LÓGICA DE INTERACTIVIDAD - SECCIÓN INICIO
 * Escuela Rural N°940 "Educación para las Primaveras"
 */

document.addEventListener('DOMContentLoaded', () => {
    // 1. Manejo del formulario de contacto
    const formulario = document.getElementById('form-contacto');
    
    if (formulario) {
        formulario.addEventListener('submit', (evento) => {
            // Evita el comportamiento por defecto de recargar la página
            evento.preventDefault();
            
            // Obtiene los valores de los inputs
            const nombre = document.getElementById('input-nombre').value.trim();
            const email = document.getElementById('input-email').value.trim();
            const asunto = document.getElementById('input-asunto').value.trim();
            const mensaje = document.getElementById('input-mensaje').value.trim();
            
            // Validación simple
            if (nombre === '' || email === '' || asunto === '' || mensaje === '') {
                alert('Por favor, completa todos los campos del formulario.');
                return;
            }
            
            // Simulación de envío
            console.log('--- Formulario Recibido ---');
            console.log(`Nombre: ${nombre}`);
            console.log(`Email: ${email}`);
            console.log(`Asunto: ${asunto}`);
            console.log(`Mensaje: ${mensaje}`);
            
            // Muestra mensaje de éxito en español
            alert(`¡Gracias ${nombre}! Tu mensaje ha sido enviado correctamente. Nos pondremos en contacto a la brevedad.`);
            
            // Limpia el formulario
            formulario.reset();
        });
    }

    // 2. Control de navegación activa
    const enlacesNav = document.querySelectorAll('.enlace-nav');
    
    enlacesNav.forEach(enlace => {
        enlace.addEventListener('click', (evento) => {
            // En caso de que se usen como anclas internas o navegación entre secciones
            enlacesNav.forEach(el => el.classList.remove('activo'));
            enlace.classList.add('activo');
        });
    });

    // 3. Animación simple de entrada al hacer scroll para los elementos principales
    const observarElementos = () => {
        const elementos = document.querySelectorAll('.plan-card, .proyecto-card, .foto-vertical-card');
        
        const opciones = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };
        
        const observador = new IntersectionObserver((entradas, observador) => {
            entradas.forEach(entrada => {
                if (entrada.isIntersecting) {
                    entrada.target.style.opacity = '1';
                    entrada.target.style.transform = 'translateY(0)';
                    observador.unobserve(entrada.target);
                }
            });
        }, opciones);

        elementos.forEach(el => {
            // Configuración inicial de estilos para la animación
            el.style.opacity = '0';
            el.style.transform = 'translateY(20px)';
            el.style.transition = 'opacity 0.6s ease-out, transform 0.6s ease-out';
            observador.observe(el);
        });
    };

    // 4. Carga de datos dinámicos desde el backend
    const cargarDatosInicio = async () => {
        // Cargar Configuración del Sitio (Datos institucionales)
        try {
            const res = await fetch('../backend/api/config.php');
            if (res.ok) {
                const config = await res.json();
                if (config && Object.keys(config).length > 0) {
                    const liElements = document.querySelectorAll('.contacto-detalles li');
                    if (liElements.length >= 3) {
                        if (config.direccion) {
                            const spanText = liElements[0].querySelector('span:not(.contacto-icon)');
                            if (spanText) spanText.textContent = config.direccion;
                        }
                        if (config.telefono) {
                            const spanText = liElements[1].querySelector('span:not(.contacto-icon)');
                            if (spanText) spanText.textContent = config.telefono;
                        }
                        if (config.correo_contacto) {
                            const spanText = liElements[2].querySelector('span:not(.contacto-icon)');
                            if (spanText) spanText.textContent = config.correo_contacto;
                        }
                    }
                }
            }
        } catch (e) {
            console.error('Error al cargar la configuración:', e);
        }

        // Cargar Proyectos (Destacados o generales en inicio)
        try {
            const res = await fetch('../backend/api/proyectos.php');
            if (res.ok) {
                const proyectos = await res.json();
                // Filtrar por destacados o simplemente tomar los primeros
                const proyectosMostrar = proyectos.filter(p => p.destacado == 1 || p.destacado === true);
                const finalProyectos = proyectosMostrar.length > 0 ? proyectosMostrar : proyectos;

                if (Array.isArray(finalProyectos) && finalProyectos.length > 0) {
                    const grid = document.querySelector('.proyectos-grid');
                    if (grid) {
                        grid.innerHTML = ''; // Vaciar estáticos
                        finalProyectos.forEach(p => {
                            const card = document.createElement('div');
                            card.className = 'proyecto-card';
                            
                            const imgContainer = document.createElement('div');
                            imgContainer.className = 'proyecto-img-container';
                            
                            const img = document.createElement('img');
                            img.src = p.url_imagen || '../src/img/inicio/imgFirstHero.png';
                            img.alt = p.titulo;
                            
                            imgContainer.appendChild(img);
                            
                            const pText = document.createElement('p');
                            pText.className = 'proyecto-texto';
                            pText.textContent = p.resumen ? `${p.titulo}: ${p.resumen}` : p.titulo;
                            
                            card.appendChild(imgContainer);
                            card.appendChild(pText);
                            grid.appendChild(card);
                        });
                    }
                }
            }
        } catch (e) {
            console.error('Error al cargar proyectos:', e);
        }

        // Cargar Galería de fotos (sección así es nuestra comunidad)
        try {
            const res = await fetch('../backend/api/galeria.php');
            if (res.ok) {
                const fotos = await res.json();
                if (Array.isArray(fotos) && fotos.length > 0) {
                    const galeriaCont = document.querySelector('.comunidad-galeria-fotos');
                    if (galeriaCont) {
                        galeriaCont.innerHTML = ''; // Vaciar estáticos
                        // Mostrar un máximo de 4 fotos
                        fotos.slice(0, 4).forEach(f => {
                            const card = document.createElement('div');
                            card.className = 'foto-vertical-card';
                            
                            const img = document.createElement('img');
                            img.src = f.url_imagen;
                            img.alt = f.texto_alternativo || f.titulo;
                            
                            card.appendChild(img);
                            galeriaCont.appendChild(card);
                        });
                    }
                }
            }
        } catch (e) {
            console.error('Error al cargar galería:', e);
        }

        // Ejecutar IntersectionObserver después de cargar dinámicamente los elementos (o sobre los estáticos de fallback)
        if ('IntersectionObserver' in window) {
            observarElementos();
        }
    };

    // Iniciar carga y enlace de animaciones
    cargarDatosInicio();
});
