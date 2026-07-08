-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-07-2026 a las 04:25:20
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `escuela_940`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_galeria`
--

CREATE TABLE `categorias_galeria` (
  `id_categoria_galeria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias_galeria`
--

INSERT INTO `categorias_galeria` (`id_categoria_galeria`, `nombre`) VALUES
(3, 'Arte'),
(4, 'Comunidad'),
(1, 'Escuela'),
(5, 'Eventos'),
(2, 'Huerta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_proyecto`
--

CREATE TABLE `categorias_proyecto` (
  `id_categoria_proyecto` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias_proyecto`
--

INSERT INTO `categorias_proyecto` (`id_categoria_proyecto`, `nombre`) VALUES
(1, 'Agroecologia'),
(2, 'Arte y Cultura'),
(3, 'Comunidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `id_curso` int(11) NOT NULL,
  `nombre_curso` varchar(50) NOT NULL,
  `turno` varchar(20) DEFAULT NULL,
  `id_docente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id_curso`, `nombre_curso`, `turno`, `id_docente`) VALUES
(1, '1er Grado', 'Mañana', NULL),
(2, '2do Grado', 'Mañana', NULL),
(3, '3er Grado', 'Mañana', NULL),
(4, '4to Grado', 'Tarde', NULL),
(5, '5to Grado', 'Tarde', NULL),
(6, '6to Grado', 'Tarde', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docentes`
--

CREATE TABLE `docentes` (
  `id_docente` int(11) NOT NULL,
  `nombre` varchar(80) NOT NULL,
  `apellido` varchar(80) NOT NULL,
  `materia` varchar(100) DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadisticas_institucionales`
--

CREATE TABLE `estadisticas_institucionales` (
  `id_estadistica` int(11) NOT NULL,
  `etiqueta` varchar(50) NOT NULL,
  `valor` varchar(20) NOT NULL,
  `id_docente` int(11) DEFAULT NULL,
  `orden` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiantes`
--

CREATE TABLE `estudiantes` (
  `id_estudiante` int(11) NOT NULL,
  `nombre` varchar(80) NOT NULL,
  `apellido` varchar(80) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `fecha_ingreso` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `galeria_fotos`
--

CREATE TABLE `galeria_fotos` (
  `id_foto` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `texto_alternativo` varchar(255) DEFAULT NULL,
  `url_imagen` varchar(255) NOT NULL,
  `id_categoria_galeria` int(11) NOT NULL,
  `id_docente` int(11) DEFAULT NULL,
  `fecha_subida` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hitos_historia`
--

CREATE TABLE `hitos_historia` (
  `id_hito` int(11) NOT NULL,
  `anio` smallint(6) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `id_docente` int(11) DEFAULT NULL,
  `orden` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes_contacto`
--

CREATE TABLE `mensajes_contacto` (
  `id_mensaje` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `asunto` varchar(150) NOT NULL,
  `mensaje` text NOT NULL,
  `ip_origen` varchar(45) DEFAULT NULL,
  `id_docente` int(11) DEFAULT NULL,
  `leido` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_envio` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planes_educativos`
--

CREATE TABLE `planes_educativos` (
  `id_plan` int(11) NOT NULL,
  `titulo` varchar(80) NOT NULL,
  `descripcion` text NOT NULL,
  `id_docente` int(11) DEFAULT NULL,
  `orden` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos`
--

CREATE TABLE `proyectos` (
  `id_proyecto` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `resumen` varchar(255) NOT NULL,
  `descripcion_completa` text NOT NULL,
  `url_imagen` varchar(255) DEFAULT NULL,
  `id_categoria_proyecto` int(11) NOT NULL,
  `id_docente` int(11) DEFAULT NULL,
  `destacado` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_publicacion` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `redes_sociales`
--

CREATE TABLE `redes_sociales` (
  `id_red` int(11) NOT NULL,
  `nombre_red` varchar(30) NOT NULL,
  `url` varchar(255) NOT NULL,
  `id_docente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secciones_comunidad`
--

CREATE TABLE `secciones_comunidad` (
  `id_seccion_comunidad` int(11) NOT NULL,
  `titulo` varchar(80) NOT NULL,
  `descripcion` text NOT NULL,
  `id_docente_referente` int(11) DEFAULT NULL,
  `orden` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `testimonios`
--

CREATE TABLE `testimonios` (
  `id_testimonio` int(11) NOT NULL,
  `nombre_autor` varchar(100) DEFAULT NULL,
  `contenido` text NOT NULL,
  `id_estudiante` int(11) DEFAULT NULL,
  `publicado` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_publicacion` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias_galeria`
--
ALTER TABLE `categorias_galeria`
  ADD PRIMARY KEY (`id_categoria_galeria`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `categorias_proyecto`
--
ALTER TABLE `categorias_proyecto`
  ADD PRIMARY KEY (`id_categoria_proyecto`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id_curso`),
  ADD UNIQUE KEY `nombre_curso` (`nombre_curso`),
  ADD KEY `idx_curso_docente` (`id_docente`);

--
-- Indices de la tabla `docentes`
--
ALTER TABLE `docentes`
  ADD PRIMARY KEY (`id_docente`);

--
-- Indices de la tabla `estadisticas_institucionales`
--
ALTER TABLE `estadisticas_institucionales`
  ADD PRIMARY KEY (`id_estadistica`),
  ADD KEY `idx_estadistica_docente` (`id_docente`);

--
-- Indices de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD PRIMARY KEY (`id_estudiante`),
  ADD KEY `idx_estudiante_curso` (`id_curso`);

--
-- Indices de la tabla `galeria_fotos`
--
ALTER TABLE `galeria_fotos`
  ADD PRIMARY KEY (`id_foto`),
  ADD KEY `idx_foto_categoria` (`id_categoria_galeria`),
  ADD KEY `idx_foto_docente` (`id_docente`);

--
-- Indices de la tabla `hitos_historia`
--
ALTER TABLE `hitos_historia`
  ADD PRIMARY KEY (`id_hito`),
  ADD KEY `idx_hito_docente` (`id_docente`);

--
-- Indices de la tabla `mensajes_contacto`
--
ALTER TABLE `mensajes_contacto`
  ADD PRIMARY KEY (`id_mensaje`),
  ADD KEY `idx_mensaje_docente` (`id_docente`),
  ADD KEY `idx_mensaje_leido` (`leido`);

--
-- Indices de la tabla `planes_educativos`
--
ALTER TABLE `planes_educativos`
  ADD PRIMARY KEY (`id_plan`),
  ADD KEY `idx_plan_docente` (`id_docente`);

--
-- Indices de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD PRIMARY KEY (`id_proyecto`),
  ADD KEY `idx_proyecto_categoria` (`id_categoria_proyecto`),
  ADD KEY `idx_proyecto_docente` (`id_docente`);

--
-- Indices de la tabla `redes_sociales`
--
ALTER TABLE `redes_sociales`
  ADD PRIMARY KEY (`id_red`),
  ADD UNIQUE KEY `nombre_red` (`nombre_red`),
  ADD KEY `idx_red_docente` (`id_docente`);

--
-- Indices de la tabla `secciones_comunidad`
--
ALTER TABLE `secciones_comunidad`
  ADD PRIMARY KEY (`id_seccion_comunidad`),
  ADD KEY `idx_seccion_docente` (`id_docente_referente`);

--
-- Indices de la tabla `testimonios`
--
ALTER TABLE `testimonios`
  ADD PRIMARY KEY (`id_testimonio`),
  ADD KEY `idx_testimonio_estudiante` (`id_estudiante`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias_galeria`
--
ALTER TABLE `categorias_galeria`
  MODIFY `id_categoria_galeria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `categorias_proyecto`
--
ALTER TABLE `categorias_proyecto`
  MODIFY `id_categoria_proyecto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `docentes`
--
ALTER TABLE `docentes`
  MODIFY `id_docente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estadisticas_institucionales`
--
ALTER TABLE `estadisticas_institucionales`
  MODIFY `id_estadistica` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  MODIFY `id_estudiante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `galeria_fotos`
--
ALTER TABLE `galeria_fotos`
  MODIFY `id_foto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `hitos_historia`
--
ALTER TABLE `hitos_historia`
  MODIFY `id_hito` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mensajes_contacto`
--
ALTER TABLE `mensajes_contacto`
  MODIFY `id_mensaje` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `planes_educativos`
--
ALTER TABLE `planes_educativos`
  MODIFY `id_plan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  MODIFY `id_proyecto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `redes_sociales`
--
ALTER TABLE `redes_sociales`
  MODIFY `id_red` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `secciones_comunidad`
--
ALTER TABLE `secciones_comunidad`
  MODIFY `id_seccion_comunidad` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `testimonios`
--
ALTER TABLE `testimonios`
  MODIFY `id_testimonio` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD CONSTRAINT `fk_curso_docente` FOREIGN KEY (`id_docente`) REFERENCES `docentes` (`id_docente`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `estadisticas_institucionales`
--
ALTER TABLE `estadisticas_institucionales`
  ADD CONSTRAINT `fk_estadistica_docente` FOREIGN KEY (`id_docente`) REFERENCES `docentes` (`id_docente`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD CONSTRAINT `fk_estudiante_curso` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `galeria_fotos`
--
ALTER TABLE `galeria_fotos`
  ADD CONSTRAINT `fk_foto_categoria` FOREIGN KEY (`id_categoria_galeria`) REFERENCES `categorias_galeria` (`id_categoria_galeria`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_foto_docente` FOREIGN KEY (`id_docente`) REFERENCES `docentes` (`id_docente`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `hitos_historia`
--
ALTER TABLE `hitos_historia`
  ADD CONSTRAINT `fk_hito_docente` FOREIGN KEY (`id_docente`) REFERENCES `docentes` (`id_docente`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `mensajes_contacto`
--
ALTER TABLE `mensajes_contacto`
  ADD CONSTRAINT `fk_mensaje_docente` FOREIGN KEY (`id_docente`) REFERENCES `docentes` (`id_docente`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `planes_educativos`
--
ALTER TABLE `planes_educativos`
  ADD CONSTRAINT `fk_plan_docente` FOREIGN KEY (`id_docente`) REFERENCES `docentes` (`id_docente`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD CONSTRAINT `fk_proyecto_categoria` FOREIGN KEY (`id_categoria_proyecto`) REFERENCES `categorias_proyecto` (`id_categoria_proyecto`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_proyecto_docente` FOREIGN KEY (`id_docente`) REFERENCES `docentes` (`id_docente`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `redes_sociales`
--
ALTER TABLE `redes_sociales`
  ADD CONSTRAINT `fk_red_docente` FOREIGN KEY (`id_docente`) REFERENCES `docentes` (`id_docente`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `secciones_comunidad`
--
ALTER TABLE `secciones_comunidad`
  ADD CONSTRAINT `fk_seccion_docente` FOREIGN KEY (`id_docente_referente`) REFERENCES `docentes` (`id_docente`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `testimonios`
--
ALTER TABLE `testimonios`
  ADD CONSTRAINT `fk_testimonio_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
