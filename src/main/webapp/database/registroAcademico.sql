-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-12-2023 a las 03:07:14
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `registroacademico`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificacionusuario`
--

CREATE TABLE `calificacionusuario` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `materia_id` int(11) DEFAULT NULL,
  `calificacion` decimal(5,2) DEFAULT NULL,
  `fecha_calificacion` date DEFAULT NULL,
  `id_evaluacion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `calificacionusuario`
--

INSERT INTO `calificacionusuario` (`id`, `usuario_id`, `materia_id`, `calificacion`, `fecha_calificacion`, `id_evaluacion`) VALUES
(106, 22, 23, 10.00, '2023-11-22', 39),
(107, 22, 23, 7.00, '2023-11-22', 40),
(108, 22, 23, 10.00, '2023-11-22', 41),
(109, 22, 23, 3.00, '2023-11-22', 42);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion`
--

CREATE TABLE `evaluacion` (
  `id` int(11) NOT NULL,
  `nombre_evaluacion` varchar(255) DEFAULT NULL,
  `porcentajeCalificacion` double NOT NULL,
  `materia_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `evaluacion`
--

INSERT INTO `evaluacion` (`id`, `nombre_evaluacion`, `porcentajeCalificacion`, `materia_id`) VALUES
(39, 'Activ1', 25, 23),
(40, 'Activ2', 25, 23),
(41, 'Parcial', 25, 23),
(42, 'parcial2', 25, 23);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historialacceso`
--

CREATE TABLE `historialacceso` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha_acceso` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tipo_acceso` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

CREATE TABLE `materia` (
  `id` int(11) NOT NULL,
  `nombre_materia` varchar(255) DEFAULT NULL,
  `codigo_acceso` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `idDocente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materia`
--

INSERT INTO `materia` (`id`, `nombre_materia`, `codigo_acceso`, `descripcion`, `idDocente`) VALUES
(23, 'Desarollo web', 'Web0807', 'web', 21);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id`, `nombre`) VALUES
(1, 'Profesor'),
(3, 'Estudiante');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `apellido`, `email`, `password`, `rol_id`) VALUES
(21, 'raul', 'valencia', 'anderson.carcamo@catolica.edu.sv', 'PTKUgucaQNk4APgnn8aMGvrgjK9RSVLpQlK66YKU6u4=', 1),
(22, 'andy', 'carcamo', 'ander@catolica.edu.sv', 'PTKUgucaQNk4APgnn8aMGvrgjK9RSVLpQlK66YKU6u4=', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuariomateria`
--

CREATE TABLE `usuariomateria` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `materia_id` int(11) DEFAULT NULL,
  `fecha_inscripcion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuariomateria`
--

INSERT INTO `usuariomateria` (`id`, `usuario_id`, `materia_id`, `fecha_inscripcion`) VALUES
(18, 22, 23, '2023-11-22');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `calificacionusuario`
--
ALTER TABLE `calificacionusuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_usuario1` (`usuario_id`),
  ADD KEY `fk_materia_calificacion1` (`materia_id`),
  ADD KEY `fk_evaluacion1` (`id_evaluacion`);

--
-- Indices de la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_materia` (`materia_id`);

--
-- Indices de la tabla `historialacceso`
--
ALTER TABLE `historialacceso`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_usuarioMateria` (`idDocente`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- Indices de la tabla `usuariomateria`
--
ALTER TABLE `usuariomateria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_usuario` (`usuario_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `calificacionusuario`
--
ALTER TABLE `calificacionusuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT de la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `historialacceso`
--
ALTER TABLE `historialacceso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `materia`
--
ALTER TABLE `materia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `usuariomateria`
--
ALTER TABLE `usuariomateria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `calificacionusuario`
--
ALTER TABLE `calificacionusuario`
  ADD CONSTRAINT `fk_evaluacion` FOREIGN KEY (`id_evaluacion`) REFERENCES `evaluacion` (`id`),
  ADD CONSTRAINT `fk_evaluacion1` FOREIGN KEY (`id_evaluacion`) REFERENCES `evaluacion` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_materia_calificacion1` FOREIGN KEY (`materia_id`) REFERENCES `materia` (`id`),
  ADD CONSTRAINT `fk_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);

--
-- Filtros para la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  ADD CONSTRAINT `fk_materia` FOREIGN KEY (`materia_id`) REFERENCES `materia` (`id`);

--
-- Filtros para la tabla `materia`
--
ALTER TABLE `materia`
  ADD CONSTRAINT `fk_usuarioMateria` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`id`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`id`);

--
-- Filtros para la tabla `usuariomateria`
--
ALTER TABLE `usuariomateria`
  ADD CONSTRAINT `fk_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
