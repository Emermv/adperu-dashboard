-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-10-2019 a las 01:36:56
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
-- Base de datos: `app_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `company`
--

CREATE TABLE `company` (
  `id` int(11) NOT NULL,
  `code` varchar(100) NOT NULL,
  `ruc` char(11) NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `direction` varchar(500) DEFAULT NULL,
  `ubigeo` varchar(15) DEFAULT NULL,
  `database_name` varchar(100) NOT NULL,
  `state` int(11) DEFAULT '1',
  `mode` int(11) DEFAULT '1',
  `creation_date` datetime DEFAULT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `company`
--

INSERT INTO `company` (`id`, `code`, `ruc`, `name`, `direction`, `ubigeo`, `database_name`, `state`, `mode`, `creation_date`, `modification_date`) VALUES
(1, 'adperu', '20518805950', 'AD PERU COMMUNICATION GROUP .S.A.C.', 'Jr. Monterrey Nro. 389', '000', 'adperu', 1, 1, '2019-10-23 00:00:00', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `role` varchar(45) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `user` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `avatar` varchar(250) DEFAULT NULL,
  `level` int(11) DEFAULT '0',
  `state` int(11) DEFAULT '1',
  `creation_date` datetime DEFAULT NULL,
  `modification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `company_id`, `name`, `role`, `email`, `user`, `password`, `avatar`, `level`, `state`, `creation_date`, `modification_date`) VALUES
(1, 1, 'Emer Isau', 'admin', 'emer.isau@gmail.com', 'emer.isau@gmail.com', 'teranova', NULL, 0, 1, '2019-10-23 00:00:00', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD UNIQUE KEY `ruc` (`ruc`),
  ADD UNIQUE KEY `database_name` (`database_name`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `company`
--
ALTER TABLE `company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
