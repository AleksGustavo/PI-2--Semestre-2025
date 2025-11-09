SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `petshop_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `petshop_db`;

CREATE TABLE `agendamento` (
  `id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL COMMENT 'FK: Qual pet está agendado (exclusão em cascata).',
  `servico_id` int(11) NOT NULL COMMENT 'FK: Qual serviço foi agendado.',
  `funcionario_id` int(11) DEFAULT NULL COMMENT 'FK: Funcionário designado. Pode ser nulo.',
  `data_agendamento` datetime NOT NULL COMMENT 'Data e hora marcadas para o agendamento.',
  `status` enum('agendado','confirmado','em_andamento','concluido','cancelado','nao_compareceu') DEFAULT 'agendado' COMMENT 'Situação atual do agendamento.',
  `observacoes` text DEFAULT NULL COMMENT 'Notas adicionais sobre o agendamento.',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Gerencia compromissos para serviços de pets (banho, tosa, consulta).';

CREATE TABLE `carteira_vacina` (
  `id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL COMMENT 'FK: O pet que recebeu a vacina (exclusão em cascata).',
  `nome_vacina` varchar(100) NOT NULL COMMENT 'Nome da vacina aplicada.',
  `data_aplicacao` date NOT NULL COMMENT 'Data em que a vacina foi aplicada.',
  `data_proxima` date DEFAULT NULL COMMENT 'Data recomendada para a próxima dose ou reforço.',
  `veterinario` varchar(100) DEFAULT NULL COMMENT 'Nome do veterinário responsável.',
  `observacoes` text DEFAULT NULL COMMENT 'Notas sobre a reação ou lote.',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Armazena o histórico de vacinação de cada pet.';

INSERT INTO `carteira_vacina` (`id`, `pet_id`, `nome_vacina`, `data_aplicacao`, `data_proxima`, `veterinario`, `observacoes`, `created_at`) VALUES
(1, 5, 'V8 Polivalente', '2024-03-01', '2025-03-01', 'Rogério Junior', '1ª dose reforço anual.', '2025-10-27 17:19:47'),
(2, 7, 'V10 Polivalente', '2025-01-10', '2026-01-10', 'Rogério Junior', 'Reforço anual.', '2025-10-27 17:19:47'),
(3, 8, 'Antirrábica', '2024-11-20', '2025-11-20', 'Rogério Junior', 'Reforço anual.', '2025-10-27 17:19:47'),
(4, 10, 'Tríplice Felina', '2024-10-05', '2025-10-05', 'Rogério Junior', 'Reforço anual.', '2025-10-27 17:19:47'),
(5, 11, 'Antirrábica', '2025-02-01', '2026-02-01', 'Rogério Junior', 'Reforço anual.', '2025-10-27 17:19:47'),
(6, 15, 'V8 Polivalente', '2024-12-15', '2025-12-15', 'Rogério Junior', '1ª dose', '2025-10-27 17:19:47'),
(7, 15, 'V8 Polivalente', '2025-01-15', '2025-12-15', 'Rogério Junior', '2ª dose', '2025-10-27 17:19:47'),
(8, 16, 'V10 Polivalente', '2025-04-10', '2026-04-10', 'Rogério Junior', 'Reforço anual.', '2025-10-27 17:19:47'),
(9, 17, 'Antirrábica Felina', '2024-12-01', '2025-12-01', 'Rogério Junior', 'Reforço anual.', '2025-10-27 17:19:47'),
(10, 20, 'V10 Polivalente', '2025-03-05', '2026-03-05', 'Rogério Junior', 'Reforço anual.', '2025-10-27 17:19:47'),
(11, 3, 'V10 Polivalente', '2024-03-10', '2025-03-10', 'Rogério Junior', 'Reforço anual.', '2025-10-28 20:17:32'),
(12, 4, 'Raiva (Antirrábica Canina)', '2025-01-20', '2026-01-20', 'Rogério Junior', 'Reforço anual.', '2025-10-28 20:17:32'),
(13, 6, 'Quádrupla Felina (V4)', '2024-09-15', '2025-09-15', 'Rogério Junior', 'Reforço anual.', '2025-10-28 20:17:32'),
(14, 9, 'V8 Polivalente', '2024-05-01', '2024-06-01', 'Rogério Junior', '1ª Dose de Puppy/Filhote.', '2025-10-28 20:17:32'),
(15, 9, 'V8 Polivalente', '2024-06-01', '2025-06-01', 'Rogério Junior', '2ª Dose de Puppy/Filhote.', '2025-10-28 20:17:32'),
(16, 11, 'V10 Polivalente', '2025-02-14', '2026-02-14', 'Rogério Junior', 'Reforço anual.', '2025-10-28 20:17:32'),
(17, 13, 'Raiva (Antirrábica Felina)', '2025-03-01', '2026-03-01', 'Rogério Junior', 'Reforço anual.', '2025-10-28 20:17:32'),
(18, 18, 'Gripe Canina (Bordetella)', '2024-10-01', '2025-04-01', 'Rogério Junior', 'Reforço semestral.', '2025-10-28 20:17:32'),
(19, 21, 'Tríplice Felina (V3)', '2024-06-01', '2025-06-01', 'Rogério Junior', 'Reforço anual.', '2025-10-28 20:17:32'),
(20, 22, 'V8 Polivalente', '2025-03-01', '2025-04-01', 'Rogério Junior', '1ª Dose de Puppy/Filhote.', '2025-10-28 20:17:32'),
(21, 22, 'V8 Polivalente', '2025-04-01', '2026-04-01', 'Rogério Junior', '2ª Dose de Puppy/Filhote.', '2025-10-28 20:17:32'),
(22, 23, 'Quíntupla Felina (V5)', '2024-09-20', '2025-09-20', 'Rogério Junior', 'Reforço anual.', '2025-10-28 20:17:32'),
(23, 24, 'V10 Polivalente', '2025-01-01', '2026-01-01', 'Rogério Junior', 'Reforço anual.', '2025-10-28 20:17:32'),
(24, 25, 'Tríplice Felina (V3)', '2024-11-01', '2025-11-01', 'Rogério Junior', 'Reforço anual.', '2025-10-28 20:17:32'),
(25, 27, 'Raiva (Antirrábica Felina)', '2024-12-01', '2025-12-01', 'Rogério Junior', 'Reforço anual.', '2025-10-28 20:17:32'),
(26, 28, 'Gripe Canina (Bordetella)', '2025-02-20', '2025-08-20', 'Rogério Junior', 'Reforço semestral.', '2025-10-28 20:17:32'),
(27, 29, 'Quádrupla Felina (V4)', '2024-10-15', '2025-10-15', 'Rogério Junior', 'Reforço anual.', '2025-10-28 20:17:32'),
(28, 30, 'Giardia Canina', '2025-03-01', '2025-09-01', 'Rogério Junior', 'Reforço semestral.', '2025-10-28 20:17:32'),
(29, 32, 'V8 Polivalente', '2024-12-05', '2025-12-05', 'Rogério Junior', 'Reforço anual.', '2025-10-28 20:17:32');

CREATE TABLE `categoria_produto` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL COMMENT 'Nome da categoria (Ex: Ração, Brinquedo).',
  `descricao` text DEFAULT NULL COMMENT 'Descrição detalhada da categoria.',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Define as categorias para organização dos produtos.';

INSERT INTO `categoria_produto` (`id`, `nome`, `descricao`, `created_at`) VALUES
(1, 'Ração', 'Alimentos para animais', '2025-09-28 16:19:19'),
(2, 'Medicamento', 'Medicamentos veterinários', '2025-09-28 16:19:19'),
(3, 'Brinquedo', 'Brinquedos para pets', '2025-09-28 16:19:19'),
(4, 'Higiene', 'Produtos de higiene e limpeza', '2025-09-28 16:19:19'),
(5, 'Acessório', 'Coleiras, guias, roupas, etc.', '2025-09-28 16:19:19');

CREATE TABLE `cliente` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL COMMENT 'Nome completo do cliente.',
  `cpf` varchar(14) DEFAULT NULL COMMENT 'Número de CPF (único).',
  `data_nascimento` date DEFAULT NULL COMMENT 'Data de nascimento.',
  `telefone` varchar(15) NOT NULL COMMENT 'Telefone de contato.',
  `email` varchar(100) DEFAULT NULL COMMENT 'Endereço de e-mail.',
  `cep` varchar(10) DEFAULT NULL,
  `rua` varchar(150) DEFAULT NULL,
  `bairro` varchar(100) DEFAULT NULL,
  `numero` varchar(20) DEFAULT NULL,
  `complemento` varchar(100) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT 1 COMMENT 'Indica se o cliente está ativo (1=Sim, 0=Não).',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Dados cadastrais dos proprietários dos pets.';

INSERT INTO `cliente` (`id`, `nome`, `cpf`, `data_nascimento`, `telefone`, `email`, `cep`, `rua`, `bairro`, `numero`, `complemento`, `observacoes`, `ativo`, `created_at`, `updated_at`) VALUES
(1, 'Aleksander Gustavo', '44165933875', '1997-07-28', '19971508170', NULL, '13616-140', 'Rua Evaristo Harder', 'Jardim Primavera', '426', '', NULL, 1, '2025-10-22 03:32:16', '2025-10-22 03:32:16'),
(2, 'Grazielle Alfinete', '44986169414', '1998-09-05', '19988761537', NULL, '13616-140', 'Rua Evaristo Harder', 'Jardim Primavera', '426', '', NULL, 1, '2025-10-27 16:48:01', '2025-10-27 16:48:01'),
(3, 'Mariana Costa', '11122233344', '1985-11-15', '11987654321', 'mariana.costa@email.com', '01000-000', 'Av. Paulista', 'Bela Vista', '1500', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(4, 'Pedro Almeida', '55566677788', '1992-03-20', '21991234567', 'pedro.a@email.com', '20000-000', 'Rua Sete de Setembro', 'Centro', '35', NULL, 'Cliente VIP. Dar 10% de desconto em produtos.', 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(5, 'Luiza Soares', '99900011122', '1975-01-10', '31975432100', 'luiza.soares@email.com', '30000-000', 'Rua da Bahia', 'Lourdes', '120', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(6, 'Carlos Mendes', '12345678900', '1988-06-25', '41988776655', 'carlos.m@email.com', '80000-000', 'Rua XV de Novembro', 'Centro', '500', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(7, 'Sofia Lima', '00112233445', '2000-09-30', '51966554433', 'sofia.lima@email.com', '90000-000', 'Av. Mauá', 'Floresta', '1010', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(8, 'Ricardo Neves', '66778899001', '1965-04-12', '81955443322', 'ricardo.n@email.com', '50000-000', 'Rua do Sol', 'Boa Vista', '25', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(9, 'Felipe Rocha', '33445566778', '1995-12-05', '71922110099', 'felipe.r@email.com', '40000-000', 'Rua Chile', 'Comércio', '10', NULL, 'Prefere contato por email.', 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(10, 'Aline Ferreira', '45678912345', '1980-02-28', '61911998877', 'aline.f@email.com', '70000-000', 'SHIS QI 01', 'Lago Sul', '50', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(11, 'Jorge Silva', '78901234567', '1970-08-18', '19971508171', 'jorge.s@email.com', '13616-140', 'Rua A', 'Vila Nova', '12', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(12, 'Helena Tavares', '23456789012', '1990-10-22', '19971508172', 'helena.t@email.com', '13616-140', 'Rua B', 'Centro', '250', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(13, 'Daniela Ribeiro', '00110011001', '1987-05-10', '11987776655', 'daniela.r@email.com', '01000-100', 'Rua Alfa', 'Centro', '10', NULL, 'Adora Labrador.', 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39'),
(14, 'Guilherme Castro', '00220022002', '1990-11-25', '21987776656', 'guilherme.c@email.com', '20000-100', 'Rua Beta', 'Tijuca', '20', NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39'),
(15, 'Fernanda Mello', '00330033003', '1979-01-15', '31987776657', 'fernanda.m@email.com', '30000-100', 'Rua Gama', 'Savassi', '30', NULL, 'Possui cão e gato.', 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39'),
(16, 'Roberto Lima', '00440044004', '1993-08-08', '41987776658', 'roberto.l@email.com', '80000-100', 'Rua Delta', 'Água Verde', '40', NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39'),
(17, 'Beatriz Pires', '00550055005', '1985-04-20', '51987776659', 'beatriz.p@email.com', '90000-100', 'Rua Epsilon', 'Moinhos', '50', NULL, 'Gatínea Persa.', 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39'),
(18, 'Gustavo Lopes', '00660066006', '1970-12-12', '11987776660', 'gustavo.l@email.com', '01000-101', 'Rua Zeta', 'Brooklin', '60', NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39'),
(19, 'Renata Nunes', '00770077007', '1996-03-01', '21987776661', 'renata.n@email.com', '20000-101', 'Rua Eta', 'Copacabana', '70', NULL, 'Dois cães grandes e pequenos.', 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39'),
(20, 'Vitor Hugo', '00880088008', '1982-10-10', '31987776662', 'vitor.h@email.com', '30000-101', 'Rua Theta', 'Funcionários', '80', NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39'),
(21, 'Marisa Diniz', '00990099009', '1991-06-06', '41987776663', 'marisa.d@email.com', '80000-102', 'Rua Iota', 'Batel', '90', NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39'),
(22, 'Lucas Fontes', '01010101010', '1984-02-02', '51987776664', 'lucas.f@email.com', '90000-102', 'Rua Kappa', 'Petrópolis', '100', NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39'),
(23, 'Aleksander Gustavo', '76757667676676', NULL, '767676676767677', NULL, '13616-140', 'Rua Evaristo Harder', 'Jardim Primavera', '426', '', NULL, 1, '2025-10-31 21:03:58', '2025-10-31 21:03:58');

CREATE TABLE `compra` (
  `id` int(11) NOT NULL,
  `fornecedor_id` int(11) NOT NULL COMMENT 'FK: Fornecedor de quem a compra foi feita.',
  `funcionario_id` int(11) DEFAULT NULL COMMENT 'FK: Funcionário que realizou o pedido.',
  `data_compra` date NOT NULL COMMENT 'Data em que a compra foi registrada.',
  `data_entrega` date DEFAULT NULL,
  `valor_total` decimal(10,2) NOT NULL COMMENT 'Valor total da compra.',
  `status` enum('pedido','recebido','cancelado') DEFAULT 'pedido' COMMENT 'Situação da compra (pedido, recebido, cancelado).',
  `forma_pagamento` varchar(50) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Registra pedidos de compra de mercadorias a fornecedores.';

INSERT INTO `compra` (`id`, `fornecedor_id`, `funcionario_id`, `data_compra`, `data_entrega`, `valor_total`, `status`, `forma_pagamento`, `observacoes`, `created_at`) VALUES
(1, 1, 10, '2025-10-01', '2025-10-05', 4500.00, 'recebido', 'Boleto', 'Compra grande de rações, estoque principal.', '2025-10-27 17:19:47'),
(2, 3, 10, '2025-10-05', '2025-10-08', 950.00, 'recebido', 'Cartão Corporativo', 'Reposição de medicamentos e antipulgas.', '2025-10-27 17:19:47'),
(3, 4, 3, '2025-10-10', '2025-10-12', 320.00, 'recebido', 'Pix', 'Shampoos e tapetes higiênicos.', '2025-10-27 17:19:47'),
(4, 2, 5, '2025-10-15', '2025-10-20', 1200.00, 'pedido', NULL, 'Brinquedos novos para o Natal.', '2025-10-27 17:19:47'),
(5, 5, 5, '2025-10-20', '2025-10-25', 850.00, 'pedido', 'Boleto', 'Coleiras, guias e camas.', '2025-10-27 17:19:47'),
(6, 6, 10, '2025-10-25', NULL, 1500.00, 'pedido', NULL, 'Rações premium, urgência.', '2025-10-27 17:19:47'),
(7, 1, 3, '2025-09-01', '2025-09-05', 3000.00, 'recebido', 'Boleto', 'Compra mensal de rações.', '2025-10-27 17:19:47'),
(8, 7, 10, '2025-09-10', '2025-09-12', 400.00, 'recebido', 'Pix', 'Suplementos.', '2025-10-27 17:19:47'),
(9, 8, 5, '2025-09-15', '2025-09-18', 600.00, 'recebido', 'Cartão Corporativo', 'Acessórios diversos e brinquedos.', '2025-10-27 17:19:47'),
(10, 9, 3, '2025-08-20', '2025-08-25', 150.00, 'recebido', 'Pix', 'Ração para roedores e rações naturais.', '2025-10-27 17:19:47');

CREATE TABLE `especie` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL COMMENT 'Nome da espécie.',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Lista as espécies de pets atendidas (Cão, Gato, etc.).';

INSERT INTO `especie` (`id`, `nome`, `created_at`) VALUES
(1, 'Cão', '2025-09-28 16:19:19'),
(2, 'Gato', '2025-09-28 16:19:19'),
(3, 'Ave', '2025-09-28 16:19:19'),
(4, 'Roedor', '2025-09-28 16:19:19'),
(5, 'Réptil', '2025-09-28 16:19:19'),
(6, 'Peixe', '2025-09-28 16:19:19');

CREATE TABLE `fornecedor` (
  `id` int(11) NOT NULL,
  `nome_fantasia` varchar(100) NOT NULL COMMENT 'Nome comercial do fornecedor.',
  `razao_social` varchar(150) DEFAULT NULL,
  `cnpj` varchar(18) NOT NULL COMMENT 'Número de CNPJ (único).',
  `telefone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contato` varchar(100) DEFAULT NULL,
  `cep` varchar(10) DEFAULT NULL,
  `rua` varchar(150) DEFAULT NULL,
  `bairro` varchar(100) DEFAULT NULL,
  `numero` varchar(20) DEFAULT NULL,
  `complemento` varchar(100) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT 1 COMMENT 'Indica se o fornecedor está ativo.',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Dados cadastrais das empresas fornecedoras de produtos.';

INSERT INTO `fornecedor` (`id`, `nome_fantasia`, `razao_social`, `cnpj`, `telefone`, `email`, `contato`, `cep`, `rua`, `bairro`, `numero`, `complemento`, `observacoes`, `ativo`, `created_at`, `updated_at`) VALUES
(1, 'Mega Ração Distribuidora', 'Mega Ração Ltda', '00111222000133', '1120203030', 'contato@megaracao.com', 'João', '01000-001', 'Rua da Ração', 'Industrial', '100', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(2, 'Brinquedos Pet Feliz', 'Pet Feliz S/A', '00444555000166', '1140405050', 'vendas@brinquedospet.com', 'Maria', '01000-002', 'Av. Brinquedo', 'Comercial', '200', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(3, 'FarmaVet', 'Farma Veterinária do Brasil', '00777888000199', '1160607070', 'comercial@farmavet.com', 'Carlos', '01000-003', 'Rod. Farmacêutica', 'Saúde', '300', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(4, 'Higiene Total Pet', 'Higiene Total Ltda', '01010101000101', '2130304040', 'vendas@higienepet.com', 'Ana', '20000-001', 'Rua Limpeza', 'Centro', '400', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(5, 'Acessórios Estilosos', 'Estilosos Pet Eireli', '02020202000102', '2150506060', 'contato@acessorios.com', 'José', '20000-002', 'Rua da Moda Pet', 'Zona Sul', '500', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(6, 'Rações Premium Sul', 'Premium Sul Distribuição', '03030303000103', '51988887777', 'vendas@premiumsul.com', 'Pedro', '90000-001', 'Av. Distribuidora', 'Industrial', '600', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(7, 'Pet Care Medicamentos', 'Care Medicamentos Ltda', '04040404000104', '1130302020', 'contato@petcarevet.com', 'Sofia', '01000-004', 'Rua dos Remédios', 'Saúde', '700', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(8, 'Global Pet Supplies', 'Global Pet S/A', '05050505000105', '4132321010', 'sales@globalpet.com', 'Márcio', '80000-001', 'Rua Logística', 'Porto', '800', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(9, 'Alimentos Naturais', 'Naturais Pet Eireli', '06060606000106', '3133334444', 'contato@naturaispet.com', 'Lúcia', '30000-001', 'Rua Orgânica', 'Verde', '900', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(10, 'Aves & Cia', 'Aves Companhia Ltda', '07070707000107', '6134345555', 'vendas@avesecia.com', 'Fernanda', '70000-001', 'Qd. dos Pássaros', 'Asa Norte', '1000', NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47');

CREATE TABLE `funcionario` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL COMMENT 'FK: Vínculo com a conta de acesso ao sistema (único).',
  `nome` varchar(100) NOT NULL COMMENT 'Nome completo do funcionário.',
  `cpf` varchar(14) NOT NULL COMMENT 'CPF do funcionário (único).',
  `telefone` varchar(15) DEFAULT NULL,
  `cep` varchar(10) DEFAULT NULL,
  `rua` varchar(150) DEFAULT NULL,
  `bairro` varchar(100) DEFAULT NULL,
  `numero` varchar(20) DEFAULT NULL,
  `complemento` varchar(100) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Dados pessoais dos funcionários, vinculados a um usuário de sistema.';

INSERT INTO `funcionario` (`id`, `usuario_id`, `nome`, `cpf`, `telefone`, `cep`, `rua`, `bairro`, `numero`, `complemento`, `observacoes`, `created_at`, `updated_at`) VALUES
(1, 3, 'Aleks Silva', '11111111111', '19988887777', '13616-001', 'Rua A', 'Bairro 1', '10', NULL, 'Responsável por Vendas e Caixa', '2025-10-17 02:13:52', '2025-10-17 02:13:52'),
(2, 6, 'Wanderson Souza', '22222222222', '19966665555', '13616-002', 'Rua B', 'Bairro 2', '20', NULL, 'Groomer Júnior', '2025-10-18 05:27:41', '2025-10-18 05:27:41'),
(3, 7, 'Administrativo Pet', '33333333333', '19955554444', '13616-003', 'Rua C', 'Bairro 3', '30', NULL, 'Responsável pelo financeiro.', '2025-10-22 03:31:11', '2025-10-22 03:31:11'),
(4, 8, 'Weslwn Santos', '44444444444', '19944443333', '13616-004', 'Rua D', 'Bairro 4', '40', NULL, 'Auxiliar de Vendas', '2025-10-27 16:27:36', '2025-10-27 16:27:36'),
(5, 9, 'Bartolomeu Oliveira', '55555555555', '11911112222', '01000-010', 'Rua dos Pinhais', 'Centro', '123', NULL, 'Vendedor Senior', '2025-10-28 13:00:00', '2025-10-28 13:00:00'),
(6, 10, 'Claudia Ferreira', '66666666666', '11933334444', '01000-011', 'Rua dos Mercados', 'Centro', '456', NULL, 'Groomer Pleno', '2025-10-28 13:05:00', '2025-10-28 13:05:00'),
(7, 11, 'Rogério Junior', '77777777777', '11955556666', '01000-012', 'Rua das Flores', 'Bela Vista', '789', NULL, 'Veterinário (Consultas)', '2025-10-28 13:10:00', '2025-10-28 13:10:00'),
(8, 12, 'Patricia Martins', '88888888888', '11977778888', '01000-013', 'Av. Ibirapuera', 'Moema', '101', NULL, 'Auxiliar de Banho e Tosa', '2025-10-28 13:15:00', '2025-10-28 13:15:00'),
(9, 1, 'Super Admin User', '99999999999', '11910101010', '01000-014', 'Rua Principal', 'Centro', '1', NULL, 'Conta de Administrador', '2025-09-28 16:19:19', '2025-09-28 16:19:19'),
(10, 2, 'Aleksander Gerente', '00000000000', '19900000000', '13616-140', 'Rua Evaristo Harder', 'Jardim Primavera', '426', NULL, 'Gerente da Loja', '2025-10-02 18:09:10', '2025-10-02 18:09:10');

CREATE TABLE `historico_consulta` (
  `id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL COMMENT 'FK: O pet que foi atendido (exclusão em cascata).',
  `data_consulta` datetime NOT NULL,
  `veterinario` varchar(100) NOT NULL COMMENT 'Nome do veterinário responsável.',
  `motivo` text DEFAULT NULL COMMENT 'Motivo da consulta.',
  `diagnostico` text DEFAULT NULL COMMENT 'Diagnóstico do veterinário.',
  `tratamento` text DEFAULT NULL COMMENT 'Tratamento prescrito.',
  `observacoes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Histórico detalhado de atendimentos veterinários.';

CREATE TABLE `item_compra` (
  `id` int(11) NOT NULL,
  `compra_id` int(11) NOT NULL COMMENT 'FK: Pedido de compra ao qual o item pertence (exclusão em cascata).',
  `produto_id` int(11) NOT NULL COMMENT 'FK: Produto comprado.',
  `quantidade` int(11) NOT NULL COMMENT 'Quantidade comprada deste produto.',
  `preco_custo_unitario` decimal(10,2) NOT NULL COMMENT 'Preço pago por uma unidade do produto.',
  `subtotal` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Detalhes dos produtos comprados em um pedido de compra.';

INSERT INTO `item_compra` (`id`, `compra_id`, `produto_id`, `quantidade`, `preco_custo_unitario`, `subtotal`, `created_at`) VALUES
(1, 1, 1, 20, 135.00, 2700.00, '2025-10-27 17:19:47'),
(2, 1, 3, 10, 90.00, 900.00, '2025-10-27 17:19:47'),
(3, 1, 4, 30, 18.00, 540.00, '2025-10-27 17:19:47'),
(4, 2, 7, 5, 55.00, 275.00, '2025-10-27 17:19:47'),
(5, 2, 8, 10, 22.00, 220.00, '2025-10-27 17:19:47'),
(6, 2, 9, 10, 40.00, 400.00, '2025-10-27 17:19:47'),
(7, 3, 19, 20, 15.00, 300.00, '2025-10-27 17:19:47'),
(8, 3, 20, 10, 12.00, 120.00, '2025-10-27 17:19:47'),
(9, 7, 2, 20, 25.00, 500.00, '2025-10-27 17:19:47'),
(10, 7, 1, 15, 135.00, 2025.00, '2025-10-27 17:19:47'),
(11, 7, 3, 5, 90.00, 450.00, '2025-10-27 17:19:47'),
(12, 10, 6, 5, 15.00, 75.00, '2025-10-27 17:19:47'),
(13, 10, 5, 5, 8.50, 42.50, '2025-10-27 17:19:47'),
(14, 9, 27, 2, 70.00, 140.00, '2025-10-27 17:19:47'),
(15, 9, 25, 10, 25.00, 250.00, '2025-10-27 17:19:47');

CREATE TABLE `item_venda` (
  `id` int(11) NOT NULL,
  `venda_id` int(11) NOT NULL COMMENT 'FK: Venda à qual o item pertence (exclusão em cascata).',
  `produto_id` int(11) NOT NULL COMMENT 'FK: Produto vendido.',
  `quantidade` int(11) NOT NULL COMMENT 'Quantidade vendida deste produto.',
  `preco_unitario` decimal(10,2) NOT NULL COMMENT 'Preço de venda unitário no momento da transação.',
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Detalhes dos produtos vendidos em uma transação.';

INSERT INTO `item_venda` (`id`, `venda_id`, `produto_id`, `quantidade`, `preco_unitario`, `subtotal`) VALUES
(1, 1, 1, 1, 189.90, 189.90),
(2, 1, 13, 1, 29.90, 29.90),
(3, 2, 7, 1, 89.90, 89.90),
(4, 3, 19, 1, 24.90, 24.90),
(5, 4, 3, 2, 135.50, 271.00),
(6, 4, 21, 2, 54.90, 109.80),
(7, 5, 5, 2, 14.90, 29.80),
(8, 5, 29, 1, 75.00, 75.00),
(9, 6, 18, 1, 69.90, 69.90),
(10, 6, 10, 1, 48.90, 48.90),
(11, 9, 25, 1, 39.90, 39.90),
(12, 10, 1, 1, 189.90, 189.90),
(13, 9, 28, 1, 49.90, 49.90),
(14, 1, 14, 1, 95.00, 95.00),
(15, 3, 20, 1, 19.90, 19.90);

CREATE TABLE `movimentacao_financeira` (
  `id` int(11) NOT NULL,
  `tipo` enum('entrada','saida') NOT NULL COMMENT 'Tipo de movimento: Entrada (receita) ou Saída (despesa).',
  `descricao` varchar(100) NOT NULL COMMENT 'Descrição resumida da movimentação.',
  `valor` decimal(10,2) NOT NULL COMMENT 'Valor da transação.',
  `data_movimentacao` date NOT NULL,
  `categoria` enum('venda_produto','servico','despesa_funcionario','despesa_operacional','compra_mercadoria','outros') DEFAULT NULL COMMENT 'Categoria financeira da movimentação.',
  `referencia_id` int(11) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Registro de todas as entradas e saídas de dinheiro.';

INSERT INTO `movimentacao_financeira` (`id`, `tipo`, `descricao`, `valor`, `data_movimentacao`, `categoria`, `referencia_id`, `observacoes`, `created_at`) VALUES
(1, 'entrada', 'Venda de Produtos (Venda ID 1)', 314.80, '2025-10-27', 'venda_produto', 1, NULL, '2025-10-27 17:19:47'),
(2, 'entrada', 'Venda de Produtos (Venda ID 2)', 89.90, '2025-10-27', 'venda_produto', 2, NULL, '2025-10-27 17:19:47'),
(3, 'entrada', 'Venda de Produtos (Venda ID 3)', 44.80, '2025-10-27', 'venda_produto', 3, NULL, '2025-10-27 17:19:47'),
(4, 'entrada', 'Venda de Produtos (Venda ID 4)', 349.11, '2025-10-27', 'venda_produto', 4, NULL, '2025-10-27 17:19:47'),
(5, 'entrada', 'Venda de Produtos (Venda ID 5)', 104.80, '2025-10-27', 'venda_produto', 5, NULL, '2025-10-27 17:19:47'),
(6, 'entrada', 'Venda de Produtos (Venda ID 6)', 118.80, '2025-10-27', 'venda_produto', 6, NULL, '2025-10-27 17:19:47'),
(7, 'entrada', 'Serviço Banho e Tosa (ID 5)', 130.00, '2025-10-27', 'servico', 7, NULL, '2025-10-27 17:19:47'),
(8, 'entrada', 'Serviço Consulta (ID 7)', 80.00, '2025-10-27', 'servico', 8, NULL, '2025-10-27 17:19:47'),
(9, 'entrada', 'Venda de Produtos (Venda ID 9)', 89.80, '2025-10-27', 'venda_produto', 9, NULL, '2025-10-27 17:19:47'),
(10, 'entrada', 'Venda de Produtos (Venda ID 10)', 189.90, '2025-10-27', 'venda_produto', 10, NULL, '2025-10-27 17:19:47'),
(11, 'saida', 'Pagamento Compra Fornecedor 1 (ID 1)', 4500.00, '2025-10-05', 'compra_mercadoria', 1, NULL, '2025-10-27 17:19:47'),
(12, 'saida', 'Pagamento Compra Fornecedor 3 (ID 2)', 950.00, '2025-10-08', 'compra_mercadoria', 2, NULL, '2025-10-27 17:19:47'),
(13, 'saida', 'Pagamento Compra Fornecedor 4 (ID 3)', 320.00, '2025-10-12', 'compra_mercadoria', 3, NULL, '2025-10-27 17:19:47'),
(14, 'saida', 'Salário Funcionário 5 (Bartolomeu)', 2500.00, '2025-10-05', 'despesa_funcionario', 5, NULL, '2025-10-27 17:19:47'),
(15, 'saida', 'Aluguel do Petshop', 3500.00, '2025-10-01', 'despesa_operacional', NULL, NULL, '2025-10-27 17:19:47');

CREATE TABLE `papel` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL COMMENT 'Nome do papel (Ex: SuperAdmin, FuncionarioVendas).',
  `descricao` text DEFAULT NULL COMMENT 'Permissões e responsabilidades do papel.',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Define os níveis de acesso (funções/roles) dos usuários no sistema.';

INSERT INTO `papel` (`id`, `nome`, `descricao`, `created_at`) VALUES
(1, 'SuperAdmin', 'Acesso total e gerenciamento de usuários.', '2025-09-28 16:19:19'),
(2, 'FuncionarioVendas', 'Permissões para CRUD em vendas, clientes, agendamentos, pets. Sem acesso financeiro.', '2025-09-28 16:19:19'),
(3, 'FuncionarioServico', 'Permissões para visualizar agendamentos e registrar serviços.', '2025-09-28 16:19:19');

CREATE TABLE `pet` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cliente_id` int(11) NOT NULL COMMENT 'FK: Proprietário do pet (exclusão em cascata).',
  `especie_id` int(11) NOT NULL COMMENT 'FK: Espécie do pet (Cão, Gato, etc.).',
  `raca_id` int(11) DEFAULT NULL COMMENT 'FK: Raça do pet. Pode ser nulo.',
  `data_nascimento` date DEFAULT NULL,
  `peso` decimal(5,2) DEFAULT NULL COMMENT 'Peso em kg.',
  `cor` varchar(30) DEFAULT NULL,
  `castrado` tinyint(1) DEFAULT 0 COMMENT 'Indicador de castração (1=Sim, 0=Não).',
  `vacinado` tinyint(1) DEFAULT 0 COMMENT 'Indicador de vacinação (1=Sim, 0=Não).',
  `observacoes` text DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT 1 COMMENT 'Indica se o pet está ativo no cadastro.',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `porte` enum('Pequeno','Medio','Grande') DEFAULT NULL COMMENT 'Porte do animal, relevante principalmente para cães.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Dados cadastrais dos animais.';

INSERT INTO `pet` (`id`, `nome`, `cliente_id`, `especie_id`, `raca_id`, `data_nascimento`, `peso`, `cor`, `castrado`, `vacinado`, `observacoes`, `foto`, `ativo`, `created_at`, `updated_at`, `porte`) VALUES
(3, 'Nymeria', 1, 1, 11, '2025-12-10', 28.00, NULL, 1, 0, NULL, NULL, 1, '2025-10-27 18:58:50', '2025-10-27 18:58:50', NULL),
(4, 'Thor', 3, 1, 12, '2023-05-20', 35.50, 'Caramelo', 1, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', 'Grande'),
(5, 'Lola', 3, 1, 18, '2024-01-15', 5.20, 'Branco', 1, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', 'Pequeno'),
(6, 'Miau', 3, 2, 24, '2023-08-01', 4.10, 'Preto', 1, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', NULL),
(7, 'Spike', 4, 1, 14, '2022-11-03', 12.80, 'Tricolor', 1, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', 'Medio'),
(8, 'Kiara', 4, 1, 15, '2021-07-28', 29.00, 'Dourado', 1, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', 'Grande'),
(9, 'Bolinha', 5, 1, 13, '2024-03-10', 3.50, 'Branco', 0, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', 'Pequeno'),
(10, 'Nala', 5, 2, 25, '2022-09-05', 3.80, 'Cinzento', 1, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', NULL),
(11, 'Rex', 6, 1, 16, '2020-10-10', 40.00, 'Preto/Marrom', 1, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', 'Grande'),
(12, 'Piu', 7, 3, 33, '2024-06-20', 0.15, 'Amarelo', 0, 0, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', NULL),
(13, 'Frajola', 8, 2, 24, '2023-02-14', 5.50, 'Malhado', 1, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', NULL),
(14, 'Dori', 8, 6, NULL, '2024-04-01', 0.05, 'Azul', 0, 0, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', NULL),
(15, 'Mel', 9, 1, 17, '2023-11-20', 2.50, 'Dourado', 0, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', 'Pequeno'),
(16, 'Luna', 10, 1, 19, '2024-02-01', 1.80, 'Marrom', 1, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', 'Pequeno'),
(17, 'Mingau', 10, 2, 26, '2022-05-18', 6.00, 'Branco', 1, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', NULL),
(18, 'Juba', 11, 1, 23, '2021-01-01', 20.00, 'Creme', 1, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', 'Medio'),
(19, 'Zeca', 11, 4, 41, '2024-07-10', 1.20, 'Marrom', 0, 0, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', NULL),
(20, 'Tequila', 12, 1, 20, '2023-03-03', 8.50, 'Vermelho', 1, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', 'Medio'),
(21, 'Simba', 1, 2, 27, '2023-04-01', 6.50, 'Laranja', 1, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', NULL),
(22, 'Floquinho', 1, 1, 11, '2024-09-01', 6.00, 'Branco', 0, 0, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', 'Pequeno'),
(23, 'Fiona', 2, 2, 24, '2022-10-20', 4.50, 'Cinza', 1, 1, NULL, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47', NULL),
(24, 'Zeus', 13, 1, 12, '2022-04-01', 32.00, 'Marrom', 1, 1, NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39', 'Grande'),
(25, 'Misty', 14, 2, 25, '2023-11-10', 4.50, 'Creme', 1, 1, NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39', NULL),
(26, 'Cookie', 15, 1, 17, '2024-05-20', 3.00, 'Dourado', 0, 0, NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39', 'Pequeno'),
(27, 'Shadow', 15, 2, 24, '2023-01-01', 5.00, 'Preto', 1, 1, NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39', NULL),
(28, 'Bruce', 16, 1, 14, '2022-12-15', 13.00, 'Brindle', 1, 1, NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39', 'Medio'),
(29, 'Merlin', 17, 2, 26, '2021-09-09', 4.20, 'Branco', 1, 1, NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39', NULL),
(30, 'Apolo', 18, 1, 16, '2020-03-20', 38.00, 'Preto e Canela', 1, 1, NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39', 'Grande'),
(31, 'Pipoca', 19, 1, 13, '2024-07-01', 4.00, 'Branco', 0, 0, NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39', 'Pequeno'),
(32, 'Dexter', 19, 1, 15, '2021-10-10', 30.00, 'Dourado', 1, 1, NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39', 'Grande'),
(33, 'Bela', 20, 2, 27, '2023-05-05', 6.80, 'Malhado', 1, 1, NULL, NULL, 1, '2025-10-28 12:50:39', '2025-10-28 12:50:39', NULL),
(34, 'Nymeria', 1, 1, 23, '2025-10-31', 0.00, NULL, 0, 0, NULL, NULL, 1, '2025-10-31 21:06:10', '2025-10-31 21:06:10', NULL);

CREATE TABLE `preco_servico_porte` (
  `id` int(11) NOT NULL,
  `servico_id` int(11) NOT NULL,
  `porte` enum('Pequeno','Medio','Grande') NOT NULL,
  `preco` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `preco_servico_porte` (`id`, `servico_id`, `porte`, `preco`) VALUES
(1, 1, 'Pequeno', 35.00),
(2, 2, 'Pequeno', 45.00),
(3, 3, 'Pequeno', 70.00),
(4, 1, 'Medio', 45.00),
(5, 2, 'Medio', 60.00),
(6, 3, 'Medio', 100.00),
(7, 1, 'Grande', 60.00),
(8, 2, 'Grande', 80.00),
(9, 3, 'Grande', 130.00);

CREATE TABLE `produto` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `categoria_id` int(11) NOT NULL COMMENT 'FK: Categoria do produto.',
  `fornecedor_padrao_id` int(11) DEFAULT NULL COMMENT 'FK: Fornecedor preferencial para este produto. Pode ser nulo.',
  `preco_custo` decimal(10,2) DEFAULT NULL COMMENT 'Preço médio de custo.',
  `preco_venda` decimal(10,2) NOT NULL COMMENT 'Preço de venda ao público.',
  `quantidade_estoque` int(11) DEFAULT 0 COMMENT 'Quantidade atual no estoque.',
  `estoque_minimo` int(11) DEFAULT 5 COMMENT 'Alerta para reposição de estoque.',
  `codigo_barras` varchar(50) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Catálogo e estoque de produtos para venda.';

INSERT INTO `produto` (`id`, `nome`, `descricao`, `categoria_id`, `fornecedor_padrao_id`, `preco_custo`, `preco_venda`, `quantidade_estoque`, `estoque_minimo`, `codigo_barras`, `ativo`, `created_at`, `updated_at`) VALUES
(1, 'Ração Cão Adulto Premium 15kg', 'Ração completa para cães adultos de porte médio/grande.', 1, 1, 135.00, 189.90, 50, 10, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(2, 'Ração Cão Filhote Mini 1kg', 'Ração super premium para filhotes de raças pequenas.', 1, 1, 25.00, 39.90, 80, 15, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(3, 'Ração Gato Castrado Salmão 7kg', 'Ração específica para gatos castrados, sabor salmão.', 1, 6, 90.00, 135.50, 40, 8, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(4, 'Ração Gato Filhote Frango 1kg', 'Ração premium para gatos filhotes.', 1, 6, 18.00, 27.90, 60, 10, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(5, 'Ração Pássaros Calopsita 500g', 'Mix de sementes e grãos para calopsitas.', 1, 10, 8.50, 14.90, 120, 20, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(6, 'Ração Roedores Porquinho-da-Índia 1kg', 'Ração extrusada para porquinhos-da-índia.', 1, 9, 15.00, 24.50, 70, 15, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(7, 'Antipulgas Cães 10-20kg (1 comp.)', 'Comprimido mastigável com proteção de 30 dias.', 2, 3, 55.00, 89.90, 30, 5, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(8, 'Vermífugo Gatos (4 tabs.)', 'Elimina vermes intestinais em gatos.', 2, 7, 22.00, 35.00, 50, 10, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(9, 'Antipulgas Gatos (1 pipeta)', 'Pipeta para aplicação tópica, proteção de 1 mês.', 2, 3, 40.00, 65.00, 25, 5, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(10, 'Suplemento Ômega 3 Cães e Gatos', 'Suplemento para pele e pelos (30 caps).', 2, 7, 30.00, 48.90, 40, 8, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(11, 'Probiótico Pet 14g', 'Pasta oral para equilíbrio da flora intestinal.', 2, 7, 35.00, 59.90, 20, 5, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(12, 'Colírio Veterinário 10ml', 'Tratamento para conjuntivite e irritações oculares.', 2, 3, 12.00, 21.90, 60, 10, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(13, 'Osso de Nylon Mordedor Grande', 'Brinquedo resistente para cães de grande porte.', 3, 2, 18.00, 29.90, 100, 20, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(14, 'Arranhador de Gato Toca Simples', 'Arranhador compacto com uma pequena toca.', 3, 2, 60.00, 95.00, 20, 5, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(15, 'Vara de Pesca para Gatos', 'Brinquedo interativo com penas.', 3, 5, 7.50, 12.90, 150, 30, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(16, 'Bola de Borracha Maciça Cão Pequeno', 'Bola super resistente, diâmetro 5cm.', 3, 2, 5.50, 9.50, 200, 40, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(17, 'Túnel para Roedores', 'Brinquedo de plástico para hamsters e ratos.', 3, 8, 11.00, 18.90, 80, 15, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(18, 'Brinquedo Kong Classic M', 'Brinquedo interativo e dispensador de petiscos.', 3, 8, 45.00, 69.90, 30, 5, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(19, 'Shampoo Neutro Cães e Gatos 500ml', 'Shampoo hipoalergênico para banho regular.', 4, 4, 15.00, 24.90, 100, 20, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(20, 'Areia Sanitária Gato Perfumada 4kg', 'Areia sanitária aglomerante com perfume.', 4, 4, 12.00, 19.90, 150, 30, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(21, 'Tapete Higiênico Cães 30un. 60x60cm', 'Tapete absorvente para treinamento sanitário.', 4, 4, 35.00, 54.90, 50, 10, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(22, 'Escova de Dentes e Creme Dental Pet', 'Kit para higiene bucal de cães e gatos.', 4, 4, 18.00, 29.90, 70, 15, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(23, 'Cortador de Unhas Profissional', 'Alicate ergonômico com trava de segurança.', 4, 8, 20.00, 34.90, 40, 8, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(24, 'Removedor de Pelos Lavável', 'Luva removedora de pelos para todos os pets.', 4, 5, 13.00, 21.50, 90, 18, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(25, 'Coleira e Guia Cão Pequeno P', 'Conjunto em nylon ajustável e resistente.', 5, 5, 25.00, 39.90, 60, 12, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(26, 'Peitoral Gato Regulável', 'Peitoral com guia para gatos, modelo H.', 5, 5, 18.00, 28.50, 50, 10, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(27, 'Cama Redonda para Cães M', 'Cama confortável e lavável, diâmetro 60cm.', 5, 8, 70.00, 119.90, 25, 5, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(28, 'Bebedouro e Comedouro Duplo', 'Tigelas em aço inox para cães e gatos.', 5, 5, 30.00, 49.90, 40, 8, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(29, 'Transporte para Calopsita', 'Gaiola pequena para transporte de aves.', 5, 10, 45.00, 75.00, 20, 5, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(30, 'Roupa de Inverno Cão P', 'Casaco de fleece para cães de pequeno porte.', 5, 5, 35.00, 59.90, 30, 6, NULL, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47');

CREATE TABLE `raca` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `especie_id` int(11) NOT NULL COMMENT 'FK: Espécie à qual a raça pertence (exclusão em cascata).',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Lista as raças de pets disponíveis, vinculadas à espécie.';

INSERT INTO `raca` (`id`, `nome`, `especie_id`, `created_at`) VALUES
(12, 'Labrador', 1, '2025-10-25 17:42:22'),
(13, 'Poodle', 1, '2025-10-25 17:42:22'),
(14, 'Bulldog Francês', 1, '2025-10-25 17:42:22'),
(15, 'Golden Retriever', 1, '2025-10-25 17:42:22'),
(16, 'Pastor Alemão', 1, '2025-10-25 17:42:22'),
(17, 'Yorkshire Terrier', 1, '2025-10-25 17:42:22'),
(18, 'Shih Tzu', 1, '2025-10-25 17:42:22'),
(19, 'Chihuahua', 1, '2025-10-25 17:42:22'),
(20, 'Dachshund', 1, '2025-10-25 17:42:22'),
(21, 'Terra Nova', 1, '2025-10-25 17:42:22'),
(22, 'Golden Retriever', 1, '2025-10-25 17:42:22'),
(23, 'Chow Chow', 1, '2025-10-25 17:42:22'),
(24, 'Sem Raça Definida', 2, '2025-10-25 17:42:22'),
(25, 'Siamês', 2, '2025-10-25 17:42:22'),
(26, 'Persa', 2, '2025-10-25 17:42:22'),
(27, 'Maine Coon', 2, '2025-10-25 17:42:22'),
(28, 'Sphynx', 2, '2025-10-25 17:42:22'),
(29, 'Ragdoll', 2, '2025-10-25 17:42:22'),
(30, 'Angorá', 2, '2025-10-25 17:42:22'),
(31, 'Bengal', 2, '2025-10-25 17:42:22'),
(32, 'British Shorthair', 2, '2025-10-25 17:42:22'),
(33, 'Calopsita', 3, '2025-10-25 17:42:22'),
(34, 'Periquito', 3, '2025-10-25 17:42:22'),
(35, 'Canário', 3, '2025-10-25 17:42:22'),
(36, 'Agapornis', 3, '2025-10-25 17:42:22'),
(37, 'Arara', 3, '2025-10-25 17:42:22'),
(38, 'Papagaio', 3, '2025-10-25 17:42:22'),
(39, 'Hamster Sírio', 4, '2025-10-25 17:42:22'),
(40, 'Hamster Anão Russo', 4, '2025-10-25 17:42:22'),
(41, 'Porquinho-da-Índia', 4, '2025-10-25 17:42:22'),
(42, 'Chinchila', 4, '2025-10-25 17:42:22'),
(43, 'Twister (Rato de Estimação)', 4, '2025-10-25 17:42:22');

CREATE TABLE `servico` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL COMMENT 'Preço padrão do serviço.',
  `duracao_media` int(11) DEFAULT NULL COMMENT 'Tempo médio de duração em minutos.',
  `ativo` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Catálogo de serviços oferecidos (banho, tosa, consultas).';

INSERT INTO `servico` (`id`, `nome`, `descricao`, `preco`, `duracao_media`, `ativo`, `created_at`, `updated_at`) VALUES
(1, 'Banho', 'Banho completo com produtos adequados', 35.00, 45, 1, '2025-09-28 16:19:19', '2025-09-28 16:19:19'),
(2, 'Tosa', 'Tosa higiênica ou tosa completa', 45.00, 60, 1, '2025-09-28 16:19:19', '2025-09-28 16:19:19'),
(3, 'Banho e Tosa', 'Pacote completo de banho e tosa', 70.00, 90, 1, '2025-09-28 16:19:19', '2025-09-28 16:19:19'),
(4, 'Consulta Veterinária', 'Consulta com veterinário', 80.00, 30, 1, '2025-09-28 16:19:19', '2025-09-28 16:19:19'),
(5, 'Hidratação', 'Hidratação para pelos ressecados', 25.00, 30, 1, '2025-09-28 16:19:19', '2025-09-28 16:19:19');

CREATE TABLE `servico_realizado` (
  `id` int(11) NOT NULL,
  `agendamento_id` int(11) DEFAULT NULL COMMENT 'FK: Vínculo opcional com um agendamento prévio.',
  `pet_id` int(11) NOT NULL COMMENT 'FK: Pet que recebeu o serviço.',
  `servico_id` int(11) NOT NULL COMMENT 'FK: Serviço que foi realizado.',
  `funcionario_id` int(11) DEFAULT NULL,
  `data_servico` datetime DEFAULT current_timestamp(),
  `valor` decimal(10,2) NOT NULL COMMENT 'Valor final cobrado pelo serviço.',
  `observacoes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Registro de um serviço que foi efetivamente concluído.';

CREATE TABLE `super_usuario` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL COMMENT 'FK: Usuário com permissão de SuperAdmin (único).',
  `cargo` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Vínculo de usuários com o papel de SuperAdmin.';

INSERT INTO `super_usuario` (`id`, `usuario_id`, `cargo`, `created_at`) VALUES
(1, 1, 'Administrador Master', '2025-09-28 16:19:19');

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL COMMENT 'Nome de usuário (login).',
  `senha_hash` varchar(255) NOT NULL COMMENT 'Hash da senha para segurança.',
  `email` varchar(100) NOT NULL COMMENT 'Email de contato (único).',
  `papel_id` int(11) NOT NULL COMMENT 'FK: Nível de permissão/acesso no sistema.',
  `ativo` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Contas de acesso ao sistema.';

INSERT INTO `usuario` (`id`, `usuario`, `senha_hash`, `email`, `papel_id`, `ativo`, `created_at`, `updated_at`) VALUES
(1, 'superadmin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'superadmin@petshop.com', 1, 1, '2025-09-28 16:19:19', '2025-09-28 16:19:19'),
(2, 'aleksander', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'aleksander@petshop.com', 1, 1, '2025-10-02 18:09:10', '2025-10-02 18:09:10'),
(3, 'Aleks', '$2y$10$MPSHs.scMLC//18Xxhlcxelx28Qm.htsWISO.aAIfHn0h5PxuOEuK', 'Aleks@petshop.com', 2, 1, '2025-10-17 02:13:52', '2025-10-17 02:13:52'),
(6, 'Wanderson', '123456', 'wanderson@hotmail.com', 2, 1, '2025-10-18 05:27:41', '2025-10-18 05:27:41'),
(7, 'admin', '$2y$10$rtkxi1teQqGJbSfsrXnca.grZltwJhIQYw1pjbN56CjzgqkYPFsxi', 'admin@petshop.com', 2, 1, '2025-10-22 03:31:11', '2025-10-22 03:31:11'),
(8, 'weslwn', '$2y$10$gkGMIq2LxkCbuHrUi64yyOn1hVYIL/Z5REy0n3Xtr5Mc0CEe1GnSa', 'weslwn@petshop.com', 2, 1, '2025-10-27 16:27:36', '2025-10-27 16:27:36'),
(9, 'bartolomeu', 'hash_senha_9', 'bartolomeu@petshop.com', 2, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(10, 'claudia', 'hash_senha_10', 'claudia@petshop.com', 2, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(11, 'rogerio', 'hash_senha_11', 'rogerio@petshop.com', 3, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47'),
(12, 'patricia', 'hash_senha_12', 'patricia@petshop.com', 3, 1, '2025-10-27 17:19:47', '2025-10-27 17:19:47');

CREATE TABLE `vacina` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL COMMENT 'Nome comercial da vacina (Ex: V8, Raiva, Gripe).',
  `doenca_protecao` varchar(150) DEFAULT NULL COMMENT 'Doença(s) que a vacina previne.',
  `validade_padrao_meses` int(11) DEFAULT 12 COMMENT 'Validade padrão em meses para a próxima dose/reforço.',
  `preco` decimal(10,2) DEFAULT NULL COMMENT 'Preço de venda sugerido.',
  `observacoes` text DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT 1 COMMENT 'Indica se a vacina está ativa no catálogo.',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `especie_id` int(11) NOT NULL COMMENT 'FK: Espécie do pet para a qual a vacina se aplica.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Catálogo de vacinas disponíveis para aplicação.';

INSERT INTO `vacina` (`id`, `nome`, `doenca_protecao`, `validade_padrao_meses`, `preco`, `observacoes`, `ativo`, `created_at`, `updated_at`, `especie_id`) VALUES
(1, 'V8 Polivalente', 'Cinonose, Parvovirose, Adenovirose, Hepatite, Parainfluenza, Coronavírus, Leptospirose', 12, 80.00, NULL, 1, '2025-10-28 12:50:14', '2025-10-28 12:50:14', 1),
(2, 'V10 Polivalente', 'V8 + Leptospirose (tipos L. grippotyphosa e L. pomona)', 12, 95.00, NULL, 1, '2025-10-28 12:50:14', '2025-10-28 12:50:14', 1),
(3, 'Gripe Canina (Bordetella)', 'Tosse dos Canis (Bordetella bronchiseptica e Parainfluenza)', 6, 60.00, NULL, 1, '2025-10-28 12:50:14', '2025-10-28 12:50:14', 1),
(4, 'Raiva (Antirrábica Canina)', 'Raiva', 12, 50.00, NULL, 1, '2025-10-28 12:50:14', '2025-10-28 12:50:14', 1),
(5, 'Giardia Canina', 'Giardia sp.', 6, 75.00, NULL, 1, '2025-10-28 12:50:14', '2025-10-28 12:50:14', 1),
(6, 'Tríplice Felina (V3)', 'Panleucopenia, Rinotraqueíte, Calicivirose', 12, 70.00, NULL, 1, '2025-10-28 12:50:14', '2025-10-28 12:50:14', 2),
(7, 'Quádrupla Felina (V4)', 'V3 + Clamidiose', 12, 85.00, NULL, 1, '2025-10-28 12:50:14', '2025-10-28 12:50:14', 2),
(8, 'Quíntupla Felina (V5)', 'V4 + Leucemia Felina (FELV)', 12, 120.00, NULL, 1, '2025-10-28 12:50:14', '2025-10-28 12:50:14', 2),
(9, 'Raiva (Antirrábica Felina)', 'Raiva', 12, 50.00, NULL, 1, '2025-10-28 12:50:14', '2025-10-28 12:50:14', 2);

CREATE TABLE `venda` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL COMMENT 'FK: Cliente que realizou a compra. Pode ser nulo (venda anônima).',
  `funcionario_id` int(11) DEFAULT NULL,
  `data_venda` datetime DEFAULT current_timestamp(),
  `valor_total` decimal(10,2) NOT NULL COMMENT 'Valor total da venda.',
  `desconto` decimal(10,2) DEFAULT 0.00 COMMENT 'Valor total de desconto aplicado.',
  `forma_pagamento` enum('dinheiro','cartao_credito','cartao_debito','pix','transferencia') DEFAULT NULL COMMENT 'Forma de pagamento utilizada.',
  `observacoes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Registro de vendas de produtos e/ou serviços.';

INSERT INTO `venda` (`id`, `cliente_id`, `funcionario_id`, `data_venda`, `valor_total`, `desconto`, `forma_pagamento`, `observacoes`, `created_at`) VALUES
(1, 3, 4, '2025-10-27 10:30:00', 219.80, 0.00, 'cartao_credito', 'Venda de ração e brinquedo.', '2025-10-27 17:19:47'),
(2, 5, 5, '2025-10-27 11:00:00', 89.90, 0.00, 'pix', 'Medicamento para pulgas.', '2025-10-27 17:19:47'),
(3, NULL, 4, '2025-10-27 12:00:00', 24.90, 0.00, 'dinheiro', 'Venda avulsa de shampoo.', '2025-10-27 17:19:47'),
(4, 4, 5, '2025-10-27 13:00:00', 387.90, 38.79, 'cartao_debito', 'Venda de ração grande com desconto VIP.', '2025-10-27 17:19:47'),
(5, 7, 4, '2025-10-27 14:00:00', 49.90, 0.00, 'pix', 'Ração e acessório para pássaro.', '2025-10-27 17:19:47'),
(6, 9, 5, '2025-10-27 15:00:00', 69.90, 0.00, 'cartao_credito', 'Brinquedo e suplemento.', '2025-10-27 17:19:47'),
(7, 1, 4, '2025-10-27 16:00:00', 130.00, 0.00, 'pix', 'Pagamento de serviço realizado (Nymeria).', '2025-10-27 17:19:47'),
(8, 10, 5, '2025-10-27 17:00:00', 80.00, 0.00, 'dinheiro', 'Pagamento de serviço realizado (Consulta Nala).', '2025-10-27 17:19:47'),
(9, 12, 4, '2025-10-27 18:00:00', 39.90, 0.00, 'cartao_debito', 'Coleira e guia.', '2025-10-27 17:19:47'),
(10, 6, 5, '2025-10-27 19:00:00', 189.90, 0.00, 'cartao_credito', 'Ração Grande.', '2025-10-27 17:19:47');


ALTER TABLE `agendamento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pet_id` (`pet_id`),
  ADD KEY `servico_id` (`servico_id`),
  ADD KEY `funcionario_id` (`funcionario_id`);

ALTER TABLE `carteira_vacina`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pet_id` (`pet_id`);

ALTER TABLE `categoria_produto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome_unico` (`nome`);

ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `telefone_unico` (`telefone`),
  ADD UNIQUE KEY `cpf` (`cpf`);

ALTER TABLE `compra`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fornecedor_id` (`fornecedor_id`),
  ADD KEY `funcionario_id` (`funcionario_id`);

ALTER TABLE `especie`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome_unico` (`nome`);

ALTER TABLE `fornecedor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cnpj` (`cnpj`),
  ADD UNIQUE KEY `telefone_unico` (`telefone`);

ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario_id` (`usuario_id`),
  ADD UNIQUE KEY `cpf` (`cpf`),
  ADD UNIQUE KEY `telefone_unico` (`telefone`);

ALTER TABLE `historico_consulta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pet_id` (`pet_id`);

ALTER TABLE `item_compra`
  ADD PRIMARY KEY (`id`),
  ADD KEY `compra_id` (`compra_id`),
  ADD KEY `produto_id` (`produto_id`);

ALTER TABLE `item_venda`
  ADD PRIMARY KEY (`id`),
  ADD KEY `venda_id` (`venda_id`),
  ADD KEY `produto_id` (`produto_id`);

ALTER TABLE `movimentacao_financeira`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `papel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

ALTER TABLE `pet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`),
  ADD KEY `especie_id` (`especie_id`),
  ADD KEY `raca_id` (`raca_id`),
  ADD KEY `idx_porte` (`porte`);

ALTER TABLE `preco_servico_porte`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_servico_porte` (`servico_id`,`porte`);

ALTER TABLE `produto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoria_id` (`categoria_id`),
  ADD KEY `fk_produto_fornecedor` (`fornecedor_padrao_id`);

ALTER TABLE `raca`
  ADD PRIMARY KEY (`id`),
  ADD KEY `especie_id` (`especie_id`);

ALTER TABLE `servico`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `servico_realizado`
  ADD PRIMARY KEY (`id`),
  ADD KEY `agendamento_id` (`agendamento_id`),
  ADD KEY `pet_id` (`pet_id`),
  ADD KEY `servico_id` (`servico_id`),
  ADD KEY `funcionario_id` (`funcionario_id`);

ALTER TABLE `super_usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario_id` (`usuario_id`);

ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario` (`usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `papel_id` (`papel_id`);

ALTER TABLE `vacina`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_vacina_especie` (`especie_id`);

ALTER TABLE `venda`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`),
  ADD KEY `funcionario_id` (`funcionario_id`);


ALTER TABLE `agendamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `carteira_vacina`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

ALTER TABLE `categoria_produto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

ALTER TABLE `compra`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `especie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `fornecedor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `funcionario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `historico_consulta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `item_compra`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

ALTER TABLE `item_venda`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

ALTER TABLE `movimentacao_financeira`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

ALTER TABLE `papel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `pet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

ALTER TABLE `preco_servico_porte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

ALTER TABLE `produto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

ALTER TABLE `raca`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

ALTER TABLE `servico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `servico_realizado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `super_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

ALTER TABLE `vacina`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

ALTER TABLE `venda`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;


ALTER TABLE `agendamento`
  ADD CONSTRAINT `agendamento_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `pet` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `agendamento_ibfk_2` FOREIGN KEY (`servico_id`) REFERENCES `servico` (`id`),
  ADD CONSTRAINT `agendamento_ibfk_3` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionario` (`id`) ON DELETE SET NULL;

ALTER TABLE `carteira_vacina`
  ADD CONSTRAINT `carteira_vacina_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `pet` (`id`) ON DELETE CASCADE;

ALTER TABLE `compra`
  ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`fornecedor_id`) REFERENCES `fornecedor` (`id`),
  ADD CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionario` (`id`) ON DELETE SET NULL;

ALTER TABLE `funcionario`
  ADD CONSTRAINT `funcionario_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE;

ALTER TABLE `historico_consulta`
  ADD CONSTRAINT `historico_consulta_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `pet` (`id`) ON DELETE CASCADE;

ALTER TABLE `item_compra`
  ADD CONSTRAINT `item_compra_ibfk_1` FOREIGN KEY (`compra_id`) REFERENCES `compra` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `item_compra_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`);

ALTER TABLE `item_venda`
  ADD CONSTRAINT `item_venda_ibfk_1` FOREIGN KEY (`venda_id`) REFERENCES `venda` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `item_venda_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`);

ALTER TABLE `preco_servico_porte`
  ADD CONSTRAINT `fk_servico_porte_servico` FOREIGN KEY (`servico_id`) REFERENCES `servico` (`id`) ON DELETE CASCADE;

ALTER TABLE `vacina`
  ADD CONSTRAINT `fk_vacina_especie` FOREIGN KEY (`especie_id`) REFERENCES `especie` (`id`) ON DELETE CASCADE;
CREATE DATABASE IF NOT EXISTS `pet_e_pet_db_cdados` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pet_e_pet_db_cdados`;
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"petshop_db\",\"table\":\"usuario\"}]');

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2025-11-05 23:46:25', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"pt_BR\",\"NavigationWidth\":0}');

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';


ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);


ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
