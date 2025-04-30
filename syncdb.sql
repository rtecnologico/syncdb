-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 30/04/2025 às 17:02
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `syncdb`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `bancos`
--

CREATE TABLE `bancos` (
  `id` int(7) UNSIGNED NOT NULL,
  `nome` text DEFAULT NULL,
  `local` text DEFAULT NULL,
  `login` text DEFAULT NULL,
  `senha` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `bancos`
--

INSERT INTO `bancos` (`id`, `nome`, `local`, `login`, `senha`) VALUES
(1, 'devbd', 'localhost', 'root', NULL),
(2, 'fcdev', 'localhost', 'root', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `campos`
--

CREATE TABLE `campos` (
  `id` int(7) NOT NULL,
  `nome` text DEFAULT NULL,
  `tabela` int(7) DEFAULT NULL,
  `tipo` text DEFAULT NULL,
  `nulo` tinyint(1) DEFAULT NULL,
  `valor` text DEFAULT NULL,
  `primarydb` tinyint(1) DEFAULT NULL,
  `autoincrement` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `campos`
--

INSERT INTO `campos` (`id`, `nome`, `tabela`, `tipo`, `nulo`, `valor`, `primarydb`, `autoincrement`) VALUES
(1, 'teste1', 1, 'INT', 1, '7', NULL, NULL),
(2, 'teste2', 2, 'INT', 1, '7', 0, 0),
(3, 'camporeste', 1, 'TEXT', 1, NULL, 0, 0),
(4, 'trtrtcampo', 2, 'INT', 1, '7', 0, 0),
(5, 'id', 1, 'INT', 0, '7', 1, 1),
(6, 'id', 4, 'INT', 0, '7', 1, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tabelas`
--

CREATE TABLE `tabelas` (
  `id` int(7) UNSIGNED NOT NULL,
  `nome` text DEFAULT NULL,
  `banco` int(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tabelas`
--

INSERT INTO `tabelas` (`id`, `nome`, `banco`) VALUES
(1, 'testesync', NULL),
(2, 'teste', NULL),
(4, 'tabelaa', NULL),
(5, 'perfil', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `middlename` text DEFAULT NULL,
  `lastname` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `perfil` int(11) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='2';

--
-- Despejando dados para a tabela `users`
--

INSERT INTO `users` (`id`, `firstname`, `middlename`, `lastname`, `username`, `password`, `avatar`, `last_login`, `type`, `perfil`, `date_added`, `date_updated`) VALUES
(1, 'Ada', '', 'Marselha', 'admin', '0192023a7bbd73250516f069df18b500', 'uploads/avatars/1.png?v=1649834664', NULL, 2, 8, '2021-01-20 14:02:37', '2024-11-18 12:46:17'),
(18, 'Midas', NULL, 'Tecnologia', 'midas', '0192023a7bbd73250516f069df18b500', NULL, NULL, 1, 7, '2024-01-10 20:53:08', '2024-09-24 14:19:54'),
(19, 'Rafael', NULL, 'Souza ', 'rafael', 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, 2, 8, '2024-08-24 00:49:14', '2024-10-16 10:56:22'),
(20, 'dev', NULL, 'dev', 'dev', '202cb962ac59075b964b07152d234b70', NULL, NULL, 0, 7, '2024-10-02 21:09:24', '2024-10-02 21:09:24');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `bancos`
--
ALTER TABLE `bancos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `campos`
--
ALTER TABLE `campos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `tabelas`
--
ALTER TABLE `tabelas`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `bancos`
--
ALTER TABLE `bancos`
  MODIFY `id` int(7) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `campos`
--
ALTER TABLE `campos`
  MODIFY `id` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `tabelas`
--
ALTER TABLE `tabelas`
  MODIFY `id` int(7) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
