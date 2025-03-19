-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 05/03/2025 às 18:42
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
-- Banco de dados: `sa_materialdeconstrução`
--
CREATE DATABASE IF NOT EXISTS `sa_materialdeconstrução` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sa_materialdeconstrução`;

DELIMITER $$
--
-- Procedimentos
--
DROP PROCEDURE IF EXISTS `mySp_categoriaInsert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mySp_categoriaInsert` (IN `p_nome_categoria` VARCHAR(150), IN `p_atributo` VARCHAR(50))   BEGIN
    IF (p_nome_categoria IS NOT NULL AND p_atributo IS NOT NULL) THEN
        INSERT INTO categoria (nome, atributo)
        VALUES (p_nome_categoria, p_atributo);
    ELSE
        SELECT 'Dados da categoria não foram informados corretamente!' AS Msg;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `mySp_categoriaUpdate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mySp_categoriaUpdate` (IN `p_id_categoria` INT, IN `p_nome_categoria` VARCHAR(150), IN `p_atributo` VARCHAR(50))   BEGIN
    IF (p_id_categoria > 0 AND p_nome_categoria IS NOT NULL AND p_atributo IS NOT NULL) THEN
        UPDATE categoria 
        SET nome = p_nome_categoria, 
            atributo = p_atributo
        WHERE categoria_id = p_id_categoria;
    ELSE
        SELECT 'Dados da categoria não foram informados corretamente!' AS Msg;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `mySp_produtoInsert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mySp_produtoInsert` (IN `p_nome_produto` VARCHAR(50), IN `p_descricao` VARCHAR(150), IN `p_preco` DECIMAL(10,2), IN `p_estoque_atual` INT(20))   BEGIN
    IF (p_nome_produto IS NOT NULL AND p_preco > 0 AND p_estoque_atual >= 0) THEN
        INSERT INTO produto (nome, descricao, preco, estoque_atual)
        VALUES (p_nome_produto, p_descricao, p_preco, p_estoque_atual);
    ELSE
        SELECT 'Dados do produto não foram informados corretamente!' AS Msg;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `mySp_produtoUpdate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mySp_produtoUpdate` (IN `p_id_produto` INT, IN `p_nome_produto` VARCHAR(50), IN `p_descricao` VARCHAR(150), IN `p_preco` DECIMAL(10,2), IN `p_estoque_atual` INT(20))   BEGIN
    IF (p_id_produto > 0 AND p_nome_produto IS NOT NULL AND p_preco > 0) THEN
        UPDATE produto 
        SET nome = p_nome_produto, 
            descricao = p_descricao, 
            preco = p_preco, 
            estoque_atual = p_estoque_atual
        WHERE produto_id = p_id_produto;
    ELSE
        SELECT 'Dados do produto não foram informados corretamente!' AS Msg;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_consultaProdutoCategoria1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaProdutoCategoria1` ()   BEGIN
    SELECT 
        p.produto_id,
        p.nome AS nome_produto,
        p.descricao,
        p.preco,
        p.estoque_atual,
        c.categoria_id,
        c.nome AS nome_categoria,
        c.atributo
    FROM 
        produto p
    JOIN 
        categoria c ON p.categoria_id = c.categoria_id;
END$$

DROP PROCEDURE IF EXISTS `sp_consultaProdutoCategoria2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultaProdutoCategoria2` (IN `p_categoria_id` INT)   BEGIN
    SELECT 
        p.produto_id,
        p.nome AS nome_produto,
        p.descricao,
        p.preco,
        p.estoque_atual,
        c.categoria_id,
        c.nome AS nome_categoria,
        c.atributo
    FROM 
        produto p
    JOIN 
        categoria c ON p.categoria_id = c.categoria_id
    WHERE 
        c.categoria_id = p_categoria_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `categoria`
--

DROP TABLE IF EXISTS `categoria`;
CREATE TABLE `categoria` (
  `categoria_id` int(11) NOT NULL,
  `nome` varchar(150) DEFAULT NULL,
  `atributo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `categoria`
--

INSERT INTO `categoria` (`categoria_id`, `nome`, `atributo`) VALUES
(1, 'Cimentos e Argamassas', 'Materiais utilizados para assentamento e revestime'),
(2, 'Blocos e Tijolos', 'Elementos de construção para paredes e estruturas'),
(3, 'Agregados', 'Materiais granulados utilizados em concreto e arga'),
(4, 'Revestimentos', 'Materiais para acabamento de superfícies'),
(5, 'Tintas e Vernizes', 'Produtos para pintura e acabamento'),
(6, 'Portas e Janelas', 'Elementos de acesso e ventilação'),
(7, 'Concreto e Blocos', 'Materiais de construção estrutural'),
(8, 'Telhas e Coberturas', 'Materiais para cobertura de edificações'),
(9, 'Argamassas e Revestimentos', 'Materiais para assentamento e acabamento'),
(10, 'Madeiras e Esquadrias', 'Materiais para construção e acabamento de janelas '),
(11, 'Tubulações e Conexões', 'Materiais hidráulicos para construção'),
(12, 'Elétrica', 'Materiais elétricos para construção'),
(13, 'Iluminação', 'Produtos de iluminação para ambientes internos e e'),
(14, 'Pisos e Revestimentos', 'Materiais para pisos e revestimentos'),
(15, 'Acessórios para Construção', 'Acessórios diversos para construção'),
(16, 'Ferragens', 'Produtos metálicos para construção e acabamento'),
(17, 'Ferramentas', 'Ferramentas manuais e elétricas para construção'),
(18, 'Ferramentas Elétricas', 'Ferramentas motorizadas para construção'),
(19, 'EPI', 'Equipamentos de proteção individual'),
(20, 'Tubulações Metálicas', 'Tubos de metais para instalações hidráulicas'),
(21, 'Adesivos e Selantes', 'Produtos para vedação e colagem'),
(22, 'Ferramentas Manuais', 'Ferramentas não motorizadas para uso em construção'),
(23, 'Materiais Elétricos', 'Produtos e acessórios para instalações elétricas'),
(24, 'Materiais Hidráulicos', 'Produtos para instalações de água e esgoto'),
(25, 'Vidros e Espelhos', 'Produtos de vidro para construção e decoração'),
(26, 'Marcenaria', 'Madeiras e produtos derivados para construção'),
(27, 'Sistemas de Segurança', 'Produtos de segurança para edificações'),
(28, 'Automação Residencial', 'Tecnologia de automação para casas'),
(29, 'Aquecimento e Refrigeração', 'Sistemas e produtos para controle de temperatura'),
(30, 'Fechaduras e Cadeados', 'Mecanismos de segurança para portas e portões'),
(31, 'Tintas e Solventes', 'Produtos para pintura e manutenção de superfícies'),
(32, 'Impermeabilizantes', 'Produtos para proteção contra umidade'),
(33, 'Materiais de Serralheria', 'Produtos de metal para construção'),
(34, 'Sistemas de Irrigação', 'Produtos para irrigação de áreas verdes'),
(35, 'Decoração e Jardinagem', 'Produtos decorativos e de jardinagem'),
(36, 'Reformas e Reparos', 'Produtos para pequenos reparos e reformas');

-- --------------------------------------------------------

--
-- Estrutura para tabela `produto`
--

DROP TABLE IF EXISTS `produto`;
CREATE TABLE `produto` (
  `produto_id` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `descricao` varchar(150) DEFAULT NULL,
  `preco` int(10) DEFAULT NULL,
  `estoque_atual` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produto`
--

INSERT INTO `produto` (`produto_id`, `nome`, `descricao`, `preco`, `estoque_atual`) VALUES
(1, 'Cimento Portland', 'Saco de cimento Portland de 50kg', 25, 200),
(2, 'Tijolo Cerâmico', 'Tijolo cerâmico 9x19x29cm', 1, 1000),
(3, 'Areia Fina', 'Metro cúbico de areia fina para construção', 70, 50),
(4, 'Piso Cerâmico', 'Piso cerâmico 60x60cm', 20, 300),
(5, 'Tintas Acrílicas', 'Lata de tinta acrílica 18 litros', 150, 50),
(6, 'Porta de Madeira', 'Porta de madeira 80x210cm', 250, 20),
(7, 'Bloco de Concreto', 'Bloco de concreto 14x19x39cm', 2, 500),
(8, 'Telha Cerâmica', 'Telha cerâmica tipo colonial', 2, 800),
(9, 'Cal Hidratada', 'Saco de cal hidratada de 20kg', 18, 150),
(10, 'Aço CA-50', 'Barra de aço CA-50 10mm', 35, 100),
(11, 'Argamassa AC-II', 'Saco de argamassa AC-II de 20kg', 25, 200),
(12, 'Viga de Madeira', 'Viga de madeira 6x12x300cm', 120, 50),
(13, 'Porta de Alumínio', 'Porta de alumínio branco 80x210cm', 350, 20),
(14, 'Janelas de PVC', 'Janela de PVC 100x120cm', 400, 30),
(15, 'Tubulação de PVC', 'Tubulação de PVC 100mm', 50, 100),
(16, 'Interruptor Simples', 'Interruptor de luz simples', 5, 500),
(17, 'Tomada Dupla', 'Tomada dupla 10A', 8, 400),
(18, 'Disjuntor 20A', 'Disjuntor monopolar 20A', 15, 300),
(19, 'Fio Elétrico 2,5mm²', 'Rolo de fio elétrico 2,5mm² 100m', 100, 200),
(20, 'Luminária LED', 'Luminária LED de embutir 18W', 35, 150),
(21, 'Cimento Branco', 'Saco de cimento branco de 20kg', 28, 120),
(22, 'Pedra Brita 1', 'Metro cúbico de pedra brita 1', 120, 60),
(23, 'Piso Vinílico', 'Piso vinílico 3mm 20x120cm', 80, 90),
(24, 'Rodapé de MDF', 'Rodapé de MDF 15cm branco', 25, 200),
(25, 'Massa Corrida', 'Lata de massa corrida 18 litros', 35, 100),
(26, 'Espelho de Tomada', 'Espelho de tomada 4x2', 2, 500),
(27, 'Rejunte para Porcelanato', 'Saco de rejunte branco 5kg', 18, 200),
(28, 'Canaleta de PVC', 'Canaleta de PVC 20mm', 8, 400),
(29, 'Parafuso de Drywall', 'Parafuso de drywall 25mm', 0, 3000),
(30, 'Calha de Alumínio', 'Calha de alumínio 100mm', 45, 100),
(31, 'Telha de Fibrocimento', 'Telha de fibrocimento 244x110cm', 20, 500),
(32, 'Chapa de Compensado', 'Chapa de compensado 20mm', 150, 40),
(33, 'Fita Isolante', 'Rolo de fita isolante 20m', 5, 200),
(34, 'Broxa de Pintura', 'Broxa de pintura 4 polegadas', 7, 150),
(35, 'Carrinho de Mão', 'Carrinho de mão reforçado', 180, 30),
(36, 'Martelo de Unha', 'Martelo de unha 27mm', 25, 100);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`categoria_id`);

--
-- Índices de tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`produto_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
