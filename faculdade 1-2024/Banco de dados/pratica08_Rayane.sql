CREATE DATABASE Venda;
USE Venda;

CREATE TABLE Cliente (
idCliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
email VARCHAR(45),
cep CHAR(9),
numero VARCHAR(45),
complemento VARCHAR(45),
fkCliente INT,
CONSTRAINT cliente_indicado FOREIGN KEY (fkCliente) REFERENCES Cliente (idCliente)
);

 INSERT INTO Cliente VALUES 
(1, 'Rayane', 'raygrs@gmail.com', '05883-260', 335, 'casa 2', null),
(2, 'Piovani', 'piovani@gmail.com', '05883-268', 330, 'casa 1', null),
(3, 'Lucas', 'godoi@gmail.com', '05883-261', 336, 'casa 1', null),
(4, 'Mayara', 'mayara@gmail.com', '05883-264', 337, 'casa 3', 1),
(5, 'Sophia', 'sophia@gmail.com', '05883-263', 345, 'casa 8', 2),
(6, 'Samuel', 'samuel@gmail.com', '05883-267', 322, 'casa 8', 3),
(7, 'Matheus', 'matheus@gmail.com', '05883-269', 301, 'casa 7', 1);


CREATE TABLE Venda (
idVenda INT PRIMARY KEY AUTO_INCREMENT,
total INT,
dataVenda DATETIME,
fkCliente INT,
CONSTRAINT cliente_venda FOREIGN KEY (fkCliente) REFERENCES Cliente (idCliente)
);

INSERT INTO Venda VALUES 
(DEFAULT, 1, '2024-02-09 08:30:09', 1),
(DEFAULT, 2, '2021-02-07 09:30:09', 2),
(DEFAULT, 3, '2022-02-07 09:30:09', 3),
(DEFAULT, 7, '2023-02-07 09:30:09', 4),
(DEFAULT, 1, '2023-02-08 09:30:09', 5),
(DEFAULT, 3, '2021-02-07 09:30:09', 6),
(DEFAULT, 4, '2021-02-07 09:30:09', 7),
(DEFAULT, 8, '2021-02-07 09:30:09', 7),
(DEFAULT, 4, '2021-02-07 09:30:09', 1),
(DEFAULT, 3, '2021-02-07 09:30:09', 1);



CREATE TABLE Produto (
idProduto INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
descricao VARCHAR(45),
preco DECIMAL (6,2)
);

INSERT INTO Produto VALUES 
(DEFAULT, 'Notebook', 'book3 360 i7', 4799.00),
(DEFAULT, 'Notebook', 'book3 360 i5', 3000.00),
(DEFAULT, 'ipad', 'iPad da apple (9° geração)', 2879.00);

CREATE TABLE Carrinho (
fkProduto INT,
CONSTRAINT carrinho_produto FOREIGN KEY (fkProduto) REFERENCES Produto (idProduto),
fkVenda INT,
CONSTRAINT carrinho_venda FOREIGN KEY (fkVenda) REFERENCES Venda (idVenda),
idCarrinho INT,
quantidade INT,
CONSTRAINT pkComposta PRIMARY KEY (fkProduto, fkVenda, idCarrinho)
);

INSERT INTO Carrinho VALUES 
(1, 1, 1, 2),
(2, 2, 2, 1),
(2, 3, 3, 4),
(2, 4, 4, 6),
(3, 5, 5, 8),
(3, 6, 6, 9),
(3, 7, 7, 7),
(2, 1, 8, 8),
(3, 2, 9, 9),
(2, 8, 10, 100),
(2, 9, 10, 100),
(2, 10, 10, 100);

-- exibindo os dados de cada tabela separadamente
SELECT * FROM Cliente;
SELECT * FROM Produto;
SELECT * FROM Venda;
SELECT * FROM Carrinho;

-- Exibir os dados dos clientes e os dados de suas respectivas vendas
SELECT Cliente.nome AS Cliente,
Cliente.email AS Email,
Cliente.cep AS Cep,
Cliente.numero AS Numero,
venda.total AS Total,
venda.dataVenda AS data
FROM Cliente JOIN venda 
ON Cliente.idCliente = venda.fkCliente;

-- ) Exibir os dados de um determinado cliente (informar o nome do cliente na consulta)
-- e os dados de suas respectivas vendas

SELECT Cliente.nome AS Cliente,
Cliente.email AS Email,
Cliente.cep AS Cep,
Cliente.numero AS Numero,
venda.total AS Total,
venda.dataVenda AS data
FROM Cliente JOIN venda 
ON Cliente.idCliente = venda.fkCliente WHERE cliente.nome = 'Rayane';

--  Exibir os dados dos clientes e de suas respectivas indicações de clientes.
SELECT * FROM Cliente JOIN Cliente as Indicacoes 
	ON indicacoes.idCliente = cliente.fkCliente;
    
/* Exibir os dados dos clientes indicados e os dados dos respectivos clientes
indicadores, porém somente de um determinado cliente indicador (informar o nome
do cliente que indicou na consulta). */

SELECT * FROM Cliente JOIN Cliente as Indicacoes 
ON indicacoes.idCliente = cliente.fkCliente WHERE Indicacoes.nome = 'Rayane';

/*Exibir os dados dos clientes, os dados dos respectivos clientes que indicaram, os
dados das respectivas vendas e dos produtos*/

SELECT * FROM Cliente JOIN Cliente as indicador 
ON cliente.fkcliente = indicador.idCliente 
JOIN Venda on cliente.idCliente = venda.fkCliente
JOIN Carrinho on carrinho.fkVenda = venda.idVenda
JOIN Produto on carrinho.fkproduto = produto.idProduto;

/*) Exibir apenas a data da venda, o nome do produto e a quantidade do produto
numa determinada venda*/

SELECT venda.dataVenda,
Produto.nome,
carrinho.quantidade
FROM Venda join Carrinho on venda.idVenda = Carrinho.fkvenda
JOIN produto on carrinho.fkProduto = produto.idProduto; 

/*Exibir apenas o nome do produto, o valor do produto e a soma da quantidade de
produtos vendidos agrupados pelo nome do produto*/

SELECT produto.nome AS Produto,
produto.preco AS Preco,
sum(carrinho.quantidade) FROM Produto JOIN Carrinho
ON Carrinho.fkProduto = produto.idProduto GROUP BY produto.nome, produto.preco;

/*Inserir dados de um novo cliente. Exibir os dados dos clientes, das respectivas
vendas, e os clientes que não realizaram nenhuma venda.*/

INSERT INTO Cliente VALUES
(8, 'Benicio', 'ben@gmail.com', '05883-260', 330, 'casa 3', 1);

SELECT * FROM Cliente LEFT JOIN Venda ON Cliente.idCliente = Venda.fkCliente;

/* Exibir o valor mínimo e o valor máximo dos preços dos produtos; */
SELECT min(produto.preco) AS Minimo,
max(produto.preco) AS Maximo
FROM PRODUTO;

/* Exibir a soma e a média dos preços dos produtos */
SELECT sum(produto.preco),
avg(produto.preco) FROM PRODUTO;

/*Exibir a quantidade de preços acima da média entre todos os produtos */
SELECT COUNT(produto.preco) FROM Produto WHERE produto.preco > (select avg(produto.preco) from produto);

/* Exibir a soma dos preços distintos dos produtos; */
SELECT sum( distinct produto.preco) from Produto;

/* Exibir a soma dos preços dos produtos agrupado por uma determinada venda */
SELECT sum(produto.preco), 
venda.idVenda
 FROM PRODUTO JOIN carrinho ON produto.idProduto = carrinho.fkProduto
 JOIN venda on venda.idVenda = carrinho.fkVenda GROUP BY produto.preco, venda.idvenda;