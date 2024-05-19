CREATE DATABASE Venda;
USE Venda;

-- Professora eu não coloquei o desconto pq fiquei confusa e não soube onde usar 

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

SELECT * FROM Venda;
SELECT * FROM Produto;
SELECT * FROM Carrinho;

SELECT * FROM Cliente JOIN Venda 
	ON Cliente.idCliente = Venda.fkCliente;

SELECT * FROM Cliente JOIN Venda 
	ON Cliente.idCliente = Venda.fkCliente where cliente.nome = 'Rayane'; 
    
SELECT * FROM Cliente JOIN Cliente AS Indicador
	on indicador.idCliente  = cliente.fkCliente;
    
    SELECT * FROM Cliente JOIN Cliente AS Indicador
	on indicador.idCliente  = cliente.fkCliente Where indicador.nome = 'Rayane';
    
    
    -- Exibir os dados dos clientes, os dados dos respectivos clientes que indicaram, os
    -- dados das respectivas vendas e dos produtos.
    select * from cliente left JOIN cliente as indicador ON indicador.idCliente = cliente.fkCliente 
    JOIN Venda ON venda.fkCliente = cliente.idCliente 
    JOIN carrinho ON carrinho.fkVenda = venda.idVenda
    JOIN produto ON carrinho.fkProduto = produto.idProduto;


    SELECT * FROM Cliente JOIN Cliente AS Indicador
	on indicador.idCliente  = cliente.fkCliente;

SELECT venda.dataVenda AS Data,
produto.nome AS Produto, 
carrinho.quantidade AS Quantidade
FROM  Venda Join Carrinho 
	on venda.idVenda = carrinho.fkVenda
JOIN Produto ON produto.idProduto = carrinho.fkProduto;

SELECT produto.nome AS Produto,
produto.preco AS Preco,
carrinho.quantidade AS Quantidade,
(SELECT sum (carrinho.quantidade) GROUP BY produto.nome)
	FROM PRODUTO JOIN Carrinho ON 
    produto.idProduto = carrinho.fkProduto
    Join venda ON venda.idVenda = carrinho.fkVenda;
    

-- Exibir apenas o nome do produto, o valor do produto e a soma da quantidade de
-- produtos vendidos agrupados pelo nome do produto.

SELECT produto.nome as produto,
produto.preco as valor,
sum(carrinho.quantidade)
FROM produto join carrinho 
	on produto.idproduto = carrinho.fkproduto
    GROUP BY produto.nome, produto.preco;
    

INSERT INTO Cliente (nome, email, cep, numero, complemento, fkCliente)
VALUES ('Novo Cliente', 'novocliente@email.com', '12345-678', '123', 'Apt 101', null);

SELECT 
    c.idCliente AS 'ID Cliente',
    c.nome AS 'Nome Cliente',
    c.email AS 'Email Cliente',
    c.cep AS 'CEP Cliente',
    c.numero AS 'Número Cliente',
    c.complemento AS 'Complemento Cliente',
    v.idVenda AS 'ID Venda',
    v.total AS 'Total Venda',
    v.dataVenda AS 'Data da Venda'
FROM 
    Cliente c
LEFT JOIN 
    Venda v ON c.idCliente = v.fkCliente
ORDER BY 
    c.idCliente, v.idVenda;
    
select min(produto.preco), max(produto.preco) from produto;
SELECT sum(produto.preco), avg(produto.preco) FROM PRODUTO;
SELECT count(produto.preco) from produto where produto.preco >= (select avg(produto.preco) from produto);  
SELECT SUM(distinct preco) FROM Produto;

select venda.idVenda,
sum(produto.preco) from venda join carrinho 
	on venda.idVenda = carrinho.fkVenda 
    JOIN Produto on carrinho.fkProduto = produto.idProduto
    GROUP BY venda.idVenda;