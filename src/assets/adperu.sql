-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-10-2019 a las 01:36:45
-- Versión del servidor: 10.1.38-MariaDB
-- Versión de PHP: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `adperu`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bell`
--

CREATE TABLE `bell` (
  `id` int(11) NOT NULL,
  `form_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `code` varchar(45) DEFAULT NULL,
  `title` varchar(500) DEFAULT NULL,
  `investment` decimal(11,2) DEFAULT NULL,
  `state` int(11) DEFAULT '1',
  `creation_date` datetime DEFAULT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `bell`
--

INSERT INTO `bell` (`id`, `form_id`, `user_id`, `code`, `title`, `investment`, `state`, `creation_date`, `modification_date`) VALUES
(2, 4, 1, 'C001', 'Campa%C3%B1a%201', '4000.00', 1, '2019-10-24 19:37:15', NULL),
(3, 1, 1, 'C002', 'Campa%C3%B1a%202', '100.00', 1, '2019-10-24 19:50:25', NULL),
(4, 4, 1, 'C033', 'Campa%C3%B1a%203', '300.00', 1, '2019-10-24 21:14:48', NULL),
(5, 5, 1, 'C0043', 'Lanzamiento%20euro5', '1000.00', 1, '2019-10-24 21:35:12', NULL),
(6, 5, 1, 'cdfdfd', 'test', '5656.00', 1, '2019-10-25 18:27:12', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bell_scope`
--

CREATE TABLE `bell_scope` (
  `id` int(11) NOT NULL,
  `bell_id` int(11) NOT NULL,
  `scope_id` int(11) NOT NULL,
  `url` varchar(500) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `bell_scope`
--

INSERT INTO `bell_scope` (`id`, `bell_id`, `scope_id`, `url`, `creation_date`, `modification_date`) VALUES
(1, 6, 1, NULL, '2019-10-25 18:27:12', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `form`
--

CREATE TABLE `form` (
  `id` int(11) NOT NULL,
  `title` varchar(500) DEFAULT NULL,
  `state` int(11) DEFAULT '1',
  `creation_date` datetime DEFAULT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `form`
--

INSERT INTO `form` (`id`, `title`, `state`, `creation_date`, `modification_date`) VALUES
(1, 'Formulario 1', 1, '2019-10-23 23:17:59', NULL),
(2, 'Formulario%202', 1, '2019-10-23 23:30:36', NULL),
(3, 'Formulario%203', 1, '2019-10-23 23:41:29', NULL),
(4, 'Formulario%204', 1, '2019-10-24 15:48:13', NULL),
(5, 'campa%C3%B1a%20eurocamiones%20lanzamiento%20camion', 1, '2019-10-24 21:33:54', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lead`
--

CREATE TABLE `lead` (
  `id` int(11) NOT NULL,
  `bell_scope_id` int(11) NOT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `os` varchar(45) DEFAULT NULL,
  `browser` varchar(100) DEFAULT NULL,
  `latitude` varchar(45) DEFAULT NULL,
  `longitude` varchar(45) DEFAULT NULL,
  `geo_description` varchar(200) DEFAULT NULL,
  `state` int(11) DEFAULT '1',
  `creation_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lead`
--

INSERT INTO `lead` (`id`, `bell_scope_id`, `ip`, `os`, `browser`, `latitude`, `longitude`, `geo_description`, `state`, `creation_date`) VALUES
(1, 1, '127.0.0.1', 'Windows 10.0', 'Opera', NULL, NULL, NULL, 1, '2019-10-25 23:27:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lead_data`
--

CREATE TABLE `lead_data` (
  `id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `label` varchar(200) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lead_data`
--

INSERT INTO `lead_data` (`id`, `lead_id`, `label`, `description`, `type`, `creation_date`) VALUES
(1, 1, 'brand', 'Volkswagen', NULL, '2019-10-25 23:27:36'),
(2, 1, 'departament', 'Lima', NULL, '2019-10-25 23:27:36'),
(3, 1, 'interest', 'Menos de 1 mes', NULL, '2019-10-25 23:27:36'),
(4, 1, 'document_type', 'DNI', NULL, '2019-10-25 23:27:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `scope`
--

CREATE TABLE `scope` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `state` int(11) DEFAULT '1',
  `creation_date` datetime DEFAULT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `scope`
--

INSERT INTO `scope` (`id`, `name`, `state`, `creation_date`, `modification_date`) VALUES
(1, 'Facebook', 1, '2019-10-23 22:40:40', NULL),
(2, 'Twitter', 1, '2019-10-23 23:07:11', NULL),
(3, 'Youtube', 0, '2019-10-23 23:57:48', NULL),
(4, 'Google', 1, '2019-10-24 21:26:52', NULL),
(5, 'Octopus', 1, '2019-10-25 18:18:59', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bell`
--
ALTER TABLE `bell`
  ADD PRIMARY KEY (`id`),
  ADD KEY `form_id` (`form_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `bell_scope`
--
ALTER TABLE `bell_scope`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bell_id` (`bell_id`),
  ADD KEY `scope_id` (`scope_id`);

--
-- Indices de la tabla `form`
--
ALTER TABLE `form`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `lead`
--
ALTER TABLE `lead`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bell_scope_id` (`bell_scope_id`);

--
-- Indices de la tabla `lead_data`
--
ALTER TABLE `lead_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_id` (`lead_id`);

--
-- Indices de la tabla `scope`
--
ALTER TABLE `scope`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bell`
--
ALTER TABLE `bell`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `bell_scope`
--
ALTER TABLE `bell_scope`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `form`
--
ALTER TABLE `form`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `lead`
--
ALTER TABLE `lead`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `lead_data`
--
ALTER TABLE `lead_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `scope`
--
ALTER TABLE `scope`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `bell`
--
ALTER TABLE `bell`
  ADD CONSTRAINT `bell_ibfk_1` FOREIGN KEY (`form_id`) REFERENCES `form` (`id`),
  ADD CONSTRAINT `bell_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `app_db`.`users` (`id`);

--
-- Filtros para la tabla `bell_scope`
--
ALTER TABLE `bell_scope`
  ADD CONSTRAINT `bell_scope_ibfk_1` FOREIGN KEY (`bell_id`) REFERENCES `bell` (`id`),
  ADD CONSTRAINT `bell_scope_ibfk_2` FOREIGN KEY (`scope_id`) REFERENCES `scope` (`id`);

--
-- Filtros para la tabla `lead`
--
ALTER TABLE `lead`
  ADD CONSTRAINT `lead_ibfk_1` FOREIGN KEY (`bell_scope_id`) REFERENCES `bell_scope` (`id`);

--
-- Filtros para la tabla `lead_data`
--
ALTER TABLE `lead_data`
  ADD CONSTRAINT `lead_data_ibfk_1` FOREIGN KEY (`lead_id`) REFERENCES `lead` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
