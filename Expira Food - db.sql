--CRIAÇÃO DO BANCO DE DADOS 
CREATE DATABASE ExpiraFood;
GO

USE ExpiraFood;
GO

-- 2 CRIAÇÃO DA TABELA CLIENTE
CREATE TABLE Cliente(
id_cliente INT IDENTITY(1,1)PRIMARY KEY,
Nome VARCHAR(100)NOT NULL,
CPF CHAR(11)NOT NULL, 
Endereco VARCHAR(150) NOT NULL, 
Telefone VARCHAR(25) NOT NULL, 
Email VARCHAR(150) NULL,
Data_cadastro DATE NOT NULL
);
GO

-- 3 CRIAÇÃO DA TABELA ESTABELECIMENTO
CREATE TABLE Estabelecimentos(
id_estabelecimento INT IDENTITY(1,1) PRIMARY KEY,
Nome_fantasia VARCHAR(100) NOT NULL,
CNPJ CHAR(14) NOT NULL UNIQUE,
Telefone VARCHAR(25) NOT NULL,
Email VARCHAR(150) NULL, 
Endereco VARCHAR(100) NOT NULL,
Status_cadastro BIT NOT NULL DEFAULT 1 
);
GO

-- 4 CRIAÇÃO DA TABELA PRODUTO
CREATE TABLE Produto(
id_produto INT IDENTITY(1,1)PRIMARY KEY,
id_estabelecimento INT NOT NULL,
Nome_produto VARCHAR(100) NOT NULL,
Categoria VARCHAR(50) NOT NULL, 
Descricao_produto VARCHAR (255) NULL,
Preco_Unitario DECIMAL(10,2) NOT NULL,
Estoque INT NOT NULL,
Validade_produto DATE NOT NULL, 
Codigo_barras VARCHAR(50) NOT NULL


--CHAVE ESTRANGEIRA
CONSTRAINT FK_Produto_Estabelecimentos
FOREIGN KEY(id_estabelecimento)
REFERENCES Estabelecimentos(id_estabelecimento),
);
GO


-- 5 CRIAÇÃO DA TABELA PEDIDOS
CREATE TABLE Pedidos(
id_pedido INT IDENTITY(1,1)PRIMARY KEY,
id_cliente INT NOT NULL,
id_estabelecimento INT NOT NULL,
data_pedido DATETIME2  NOT NULL,
status_pedido VARCHAR(30) NOT NULL DEFAULT 'Pendente',
preco_unitario DECIMAL(10,2) NOT NULL,
Valor_total DECIMAL(10,2) NOT NULL,
Forma_pagamento VARCHAR(30) NULL,

CONSTRAINT FK_Pedidos_Cliente
FOREIGN KEY (id_cliente)
REFERENCES Cliente(id_cliente),

Constraint FK_Pedidos_Estabelecimentos
FOREIGN KEY(id_estabelecimento)
REFERENCES Estabelecimentos(id_estabelecimento), 

CONSTRAINT CK_Pedidos_Status
CHECK(status_pedido IN ('Pendente', 'Confirmado'))

);
GO


-- 6 CRIAÇÃO DA TABELA ITENS PEDIDOS
CREATE TABLE ItensPedido(
id_item INT IDENTITY(1,1)PRIMARY KEY,
id_pedido INT NOT NULL,
id_produto INT NOT NULL,
Quantidade INT NOT NULL,
Preco_unitario DECIMAL(10,2) NOT NULL,
Subtotal DECIMAL(10,2) NOT NULL

-- CHAVES ESTRANGEIRAS
CONSTRAINT FK_ItensPedido_Pedidos
FOREIGN KEY(id_pedido)
REFERENCES Pedidos(id_pedido),

CONSTRAINT FK_ItensPedido_Produto
FOREIGN KEY(id_produto)
REFERENCES Produto(id_produto)

);
GO