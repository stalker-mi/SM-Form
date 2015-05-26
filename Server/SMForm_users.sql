-- phpMyAdmin SQL Dump
-- version 4.1.14.3
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Май 26 2015 г., 22:24
-- Версия сервера: 5.5.40-log
-- Версия PHP: 5.3.29-pl0-gentoo

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `lesnajapol_stdnt`
--

-- --------------------------------------------------------

--
-- Структура таблицы `SMForm_users`
--

CREATE TABLE IF NOT EXISTS `SMForm_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `surname` varchar(30) NOT NULL,
  `sex` char(1) NOT NULL,
  `email` varchar(30) NOT NULL,
  `login` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `SMForm_users`
--

INSERT INTO `SMForm_users` (`id`, `name`, `surname`, `sex`, `email`, `login`, `password`) VALUES
(1, 'Василий', 'Петров', 'm', 'vdem@in-syst.ru', 'sd2', 'bf709005906087dc1256bb4449d8774d'),
(2, 'Сидоров', 'Илья', 'm', 'sidorov@mail.ru', 'sidorov', 'c83b2d5bb1fb4d93d9d064593ed6eea2'),
(3, 'Ксения', 'Левкина', 'f', 'lazy@mail.ru', 'kse', 'c44a471bd78cc6c2fea32b9fe028d30a'),
(4, 'Евгения', 'Иванова', 'f', 'ivanova@gmail.com', 'ivanova', 'c83b2d5bb1fb4d93d9d064593ed6eea2');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
