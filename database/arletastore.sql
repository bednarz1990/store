-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
--  
-- Server version: 10.1.16-MariaDB
-- PHP Version: 7.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `arletastore`
--

-- --------------------------------------------------------

--
-- Struktura bazy dla marek `brands`
--

CREATE TABLE `brands` (
  `brand_id` int(100) NOT NULL,
  `brand_title` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Marki dla `brands`
--

INSERT INTO `brands` (`brand_id`, `brand_title`) VALUES
(1, 'Gucci'),
(2, 'Egypt'),
(3, 'Jasmina');

-- --------------------------------------------------------

--
-- Struktura bazy dla koszyka `cart`
--

CREATE TABLE `cart` (
  `id` int(10) NOT NULL,
  `p_id` int(10) NOT NULL,
  `ip_add` varchar(250) NOT NULL,
  `user_id` int(10) DEFAULT NULL,
  `qty` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura bazy dla kategorii `categories`
--

CREATE TABLE `categories` (
  `cat_id` int(100) NOT NULL,
  `cat_title` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dane dla kategorii `categories`
--

INSERT INTO `categories` (`cat_id`, `cat_title`) VALUES
(1, 'balerinki'),
(2, 'botki'),
(3, 'klapki'),
(4, 'mokasynki'),
(5, 'sandalki'),
(6, 'szpilki');

-- --------------------------------------------------------

--
-- Struktura bazy dla zamowien `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `trx_id` varchar(255) NOT NULL,
  `p_status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Przykladowane dane dla zamowien `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `product_id`, `qty`, `trx_id`, `p_status`) VALUES
(1, 2, 7, 1, '07M47684BS5725041', 'Completed'),
(2, 2, 2, 1, '07M47684BS5725041', 'Completed');

-- --------------------------------------------------------

--
-- Struktura bazy dla produktow `products`
--

CREATE TABLE `products` (
  `product_id` int(100) NOT NULL,
  `product_cat` int(100) NOT NULL,
  `product_brand` int(100) NOT NULL,
  `product_title` varchar(255) NOT NULL,
  `product_price` int(100) NOT NULL,
  `product_desc` text NOT NULL,
  `product_image` text NOT NULL,
  `product_keywords` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_cat`, `product_brand`, `product_title`, `product_price`, `product_desc`, `product_image`, `product_keywords`) VALUES
(1, 1, 2, 'sandalki japonki rozowe crystal egypt', 50, 'Sandalki japonki rozowe', 'sandalki-japonki-rozowe-crystal-egypt.jpg', 'sandalki japonki rozowe'),
(2, 1, 3, 'mokasyny espadryle zamszowe granatowe marlene', 50, 'Mokasyny espadryle zamszowe granatowe marlene', 'mokasyny-espadryle-zamszowe-granatowe-marlene.jpg', 'mokasyny espadryle'),
(3, 1, 3, 'balerinki bezowe ginette', 50, 'balerinki bezowe ginette', 'balerinki-bezowe-ginette.jpg', 'balerinki bezowe ginette'),
(4, 1, 3, 'botki szpilki azurowe czarne karisma', 50, 'botki szpilki azurowe czarne karisma', 'botki-szpilki-azurowe-czarne-karisma.jpg', 'botki szpilki azurowe czarne karisma');

-- --------------------------------------------------------

--
-- Struktura bazy dla uzytkownikow `user_info`
--

CREATE TABLE `user_info` (
  `user_id` int(10) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(300) NOT NULL,
  `password` varchar(300) NOT NULL,
  `mobile` varchar(10) NOT NULL,
  `address1` varchar(300) NOT NULL,
  `address2` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Struktura bazy dla `tbl_comment`
--

CREATE TABLE IF NOT EXISTS `tbl_comment` (
  `comment_id` int(11) NOT NULL,
  `parent_comment_id` int(11) NOT NULL,
  `comment` varchar(200) NOT NULL,
  `comment_sender_name` varchar(40) NOT NULL,
  `product_id` int(100) NOT NULL, 
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

 
ALTER TABLE `tbl_comment`
  ADD PRIMARY KEY (`comment_id`);

 
ALTER TABLE `tbl_comment`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT;



--
-- Przykladowane dane dla `user_info`
--

INSERT INTO `user_info` (`user_id`, `first_name`, `last_name`, `email`, `password`, `mobile`, `address1`, `address2`) VALUES
(1, 'Flejmer', 'Anna', 'anna.flejmer@gmail.com', '25f9e794323b453885f5181f1b624d0b', '8389080183', 'Siedlce', 'Wyszynskiego'),
(2, 'Flejmer', 'Arleta', 'arleta.flejmer@gmail.com', '25f9e794323b453885f5181f1b624d0b', '8389080183', 'Siedlce', 'Wyszynskiego');

--
-- Indeksy dla tabel  
--

--
-- Indeks dla tabeli marki `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`brand_id`);

--
-- Indeks dla koszyka `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla kategorii `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indeks dla zamowien `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indeks dla produktow `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indeks dla uzytkownika `user_info`
--
ALTER TABLE `user_info`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT dla tabel
--

--
-- AUTO_INCREMENT dla marek `brands`
--
ALTER TABLE `brands`
  MODIFY `brand_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT dla koszyka `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla kategorii `categories`
--
ALTER TABLE `categories`
  MODIFY `cat_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT dla zamowien `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT dla produktow`products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT dla uzytkownikow `user_info`
--
ALTER TABLE `user_info`
  MODIFY `user_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
 
