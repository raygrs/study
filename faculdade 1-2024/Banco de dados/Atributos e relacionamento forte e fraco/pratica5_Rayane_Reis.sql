CREATE DATABASE pratica5;
USE pratica5;

CREATE TABLE Cliente (
idCliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
telFixo CHAR(9),
celular CHAR(13) NOT NULL
);

INSERT INTO Cliente VALUES 
(DEFAULT, 'Rayane', '2771-5712', '11 96525-7862'),
(DEFAULT, 'Jeane', '2098-5648', '11 96525-3412'),
(DEFAULT, 'Liz', '2771-7774', '11 96525-7895'),
(DEFAULT, 'Malia', '2771-4141', '11 96525-3356');


CREATE TABLE Endereco (
idEndereco INT NOT NULL,
fkClienteEndereco INT NOT NULL,
CONSTRAINT endereco_cliente FOREIGN KEY (fkClienteEndereco) REFERENCES Cliente (idCliente),
cep CHAR(9) NOT NULL,
numero VARCHAR(10) NOT NULL,
complemento VARCHAR(45),
CONSTRAINT pkComposta_enderecoCliente PRIMARY KEY (idEndereco, fkClienteEndereco)
);

-- PRECISEI ADICIONAR O CAMPO SOBRENOME CONFORME PEDIA NO EXERCICIO
ALTER TABLE CLIENTE ADD COLUMN sobrenome VARCHAR(45) NOT NULL;
UPDATE Cliente SET sobrenome = 'Gonçalves' WHERE idCliente in (1,2);
UPDATE Cliente SET sobrenome = 'Reis' WHERE idCliente in (3,4);


INSERT INTO Endereco VALUES
(1, 1, '05883-260','335', null),
(2, 2, '05897-570','2', 'bloco 4'),
(3, 3, '05883-260','101', 'bloco 3'),
(4, 4, '05883-777','303', 'bloco 1');


CREATE TABLE Pet (
idPet INT NOT NULL,
fkCliente INT NOT NULL,
CONSTRAINT cliente_petshop FOREIGN KEY (fkCliente) REFERENCES Cliente (idCliente),
tipo VARCHAR(45) NOT NULL,
nome VARCHAR(45) NOT NULL,
raca VARCHAR(45) NOT NULL,
dtNasc DATE NOT NULL,
CONSTRAINT pkComposta_petshop PRIMARY KEY (idPet, fkCliente)
);

INSERT INTO Pet VALUES
(1, 1, 'Cachorro', 'Scott', 'Maltês', '2019-08-26'),
(2, 2, 'Cachorro', 'Cookie', 'Lulu da pomerânea', '2019-08-26'),
(3, 3, 'Gato', 'Pantera', 'Siâmes', '2018-06-10'),
(4, 3, 'Gato', 'Flash', 'Siâmes', '2018-06-10'),
(5, 4, 'Gato', 'Marie', 'Viralata', '2017-04-16');


SELECT * FROM Cliente;
SELECT * FROM Endereco;
SELECT * FROM Pet;
ALTER TABLE Cliente MODIFY COLUMN nome VARCHAR(100);
DESCRIBE Cliente;
SELECT * FROM pet WHERE tipo = 'Gato';
SELECT nome, dtNasc FROM Pet;
SELECT * FROM Pet ORDER BY nome;

--  Exibir os dados dos clientes ordenados em ordem decrescente pelo CEP.
SELECT * FROM Cliente JOIN Endereco 
	ON cliente.idCliente = endereco.fkClienteEndereco ORDER BY endereco.cep DESC;
    
SELECT * FROM Pet WHERE nome LIKE 'S%';
SELECT * FROM Cliente WHERE sobrenome = 'Gonçalves';
UPDATE Cliente SET celular = '11 96525-1111' WHERE idCliente = 1;
SELECT * FROM Cliente;

SELECT * FROM Pet JOIN Cliente 
	ON Cliente.idCliente = Pet.fkCliente;


SELECT pet.nome AS Pet,
pet.tipo AS Tipo,
pet.raca AS Raca,
cliente.nome AS Dono,
cliente.celular AS Contato
FROM Pet Join Cliente 
	ON Cliente.idCliente = Pet.fkCliente WHERE Cliente.nome = 'Rayane';
    
    
DELETE FROM PET WHERE IdPet = 4;
SELECT * FROM pet;


-- SELECT EXTRA COM JOIN PARA PRÁTICAR 
SELECT pet.nome AS Pet,
pet.tipo AS Tipo,
pet.raca AS Raca,
cliente.nome AS Dono,
cliente.celular AS Contato,
endereco.cep AS Cep,
endereco.numero AS Numero,
endereco.complemento AS Complemento FROM Pet 
Join Cliente ON Cliente.idCliente = Pet.fkCliente
JOIN Endereco ON cliente.idCliente = endereco.fkClienteEndereco
	WHERE Cliente.nome = 'Rayane';
    

SELECT pet.nome AS Pet,
pet.tipo AS Tipo,
pet.raca AS Raca,
pet.dtNasc AS dtNasc,
cliente.nome AS Dono,
cliente.celular AS Contato,
endereco.cep AS Cep,
endereco.numero AS Numero,
endereco.complemento AS Complemento FROM Pet 
Join Cliente ON Cliente.idCliente = Pet.fkCliente
JOIN Endereco ON cliente.idCliente = endereco.fkClienteEndereco 
ORDER BY Pet.dtNasc ASC;

-- excluindo as tabelas conforme pede no exercicio
DROP TABLE Pet;
DROP TABLE Endereco;
DROP TABLE Cliente;

-- EXERCICIO DOIS ///////////////////////////////////////////////////////////

USE pratica5;

CREATE TABLE Pessoa (
idPessoa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
dtNasc DATE NOT NULL,
profissao VARCHAR(45) NOT NULL
);

CREATE TABLE Gastos (
idGastos INT NOT NULL,
data DATE NOT NULL,
valor DECIMAL (5,2) NOT NULL,
descricao VARCHAR(45) NOT NULL,
fkPessoa INT NOT NULL,
CONSTRAINT Gastos_pessoa FOREIGN KEY (fkPessoa) REFERENCES Pessoa (idPessoa),
CONSTRAINT pkComposta_gastos PRIMARY KEY (idGastos, fkPessoa)
);

INSERT INTO Pessoa VALUES 
(DEFAULT, 'Rayane', '2004-11-04', 'Programadora full stack'),
(DEFAULT, 'Jeane', '1984-04-01', 'Professora');

INSERT INTO Gastos Values
(1, '2024-03-20', '999.99', 'Setup com led', 1),
(2, '2024-03-10','150.50', 'Papelaria do ensino', 2),
(3, '2024-04-05','550.50', 'Impressora digital', 2),
(4, '2024-01-01','850.50', 'Monitor', 1);

SELECT * FROM Pessoa;
SELECT * FROM Gastos;
SELECT * FROM Gastos WHERE valor >= '500.00';

SELECT * FROM Pessoa JOIN Gastos 
	ON Pessoa.idPessoa = Gastos.fkPessoa;

SELECT 
pessoa.nome AS Pessoa,
pessoa.profissao AS Profissao,
gastos.data AS Data,
gastos.valor AS Valor,
gastos.descricao AS Descricao FROM Pessoa 
JOIN Gastos ON Pessoa.idPessoa = Gastos.fkPessoa WHERE idPessoa = 1;

SELECT 
pessoa.nome AS Pessoa,
gastos.valor AS Gastos FROM Pessoa 
JOIN Gastos ON Pessoa.idPessoa = Gastos.fkPessoa WHERE idPessoa = 2;

UPDATE Gastos SET descricao = 'Setup completo' WHERE idGastos = 1;
UPDATE Pessoa SET profissao = 'Desenvolvedora full stack' WHERE idPessoa = 1;

DELETE FROM Gastos WHERE idGastos = '1';
DELETE FROM Gastos WHERE idGastos = '3';



-- EXERCICIO 3 ///////////////////////////////////////////////////

CREATE DATABASE PraticaFuncionario;
USE PraticaFuncionario;

CREATE TABLE Setor (
idSetor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
andar VARCHAR(45) NOT NULL
);

CREATE TABLE Funcionario (
idFuncionario INT NOT NULL UNIQUE,
nome VARCHAR(45) NOT NULL,
telefone CHAR(13) NOT NULL,
salario DECIMAL (5,2) NOT NULL,
fkSetor INT NOT NULL,
CONSTRAINT setor_funcionario FOREIGN KEY (fkSetor) REFERENCES Setor (idSetor),
CONSTRAINT pkComposta_funcionario PRIMARY KEY (idFuncionario, fkSetor)
);

CREATE TABLE Acompanhante (
idAcompanhante INT NOT NULL UNIQUE,
nome VARCHAR(45) NOT NULL,
relacao VARCHAR(45) NOT NULL,
dtNasc DATE NOT NULL,
fkFuncionario INT NOT NULL,
CONSTRAINT acompanhante_funcionario FOREIGN KEY (fkFuncionario) REFERENCES Funcionario (idFuncionario),
fkSetor_funcionario INT,
CONSTRAINT setor_acompanhante_funcionario FOREIGN KEY (fkSetor_funcionario) REFERENCES Setor (idSetor),
CONSTRAINT pk_composta_acompanhante PRIMARY KEY (idAcompanhante, fkFuncionario, fkSetor_funcionario)
);

INSERT INTO Acompanhante VALUES 
(1, 'Daniela', 'Prima','2001-10-09', 1, 3),
(2, 'Ster', 'Amiga','2002-10-09', 2, 1),
(3, 'Davi', 'Sócio','2003-10-03', 3, 2),
(4, 'Bryan', 'Amigo','2004-10-04', 4, 3),
(5, 'Juan', 'Advogado','2001-10-04', 5, 4);

INSERT INTO Setor (nome, andar)VALUES 
('Administrativo', '2A'),
('Financeiro', '3A'),
('Desenvolvimento', '7A'),
('Recursos Humanos', '1A'),
('Gestão de recursos humanos', '4A');


INSERT INTO Funcionario VALUES 
(1, 'Rayane', '11 96525-1111', '190.00', 3),
(2, 'Malia', '11 96525-1112', '110.00', 1),
(3, 'Liz', '11 96525-1113', '100.00', 2),
(4, 'Alice', '11 96525-1114', '90.00', 3),
(5, 'Flora', '11 96525-1115', '10.00', 4),
(6, 'Theo', '11 96525-1116', '11.00', 5),
(7, 'Lucca', '11 96525-1117', '19.00', 1),
(8, 'Bernado', '11 96525-1118', '140.00', 2);

SELECT * FROM Setor;
SELECT * FROM Funcionario;
SELECT * FROM Acompanhante;

-- Fiz um select simples e outro mais elaborado por cada comando pedido somente para práticar !!
SELECT * FROM Setor JOIN Funcionario 
	ON setor.idSetor = funcionario.fkSetor;
    
SELECT 
setor.nome AS Setor,
setor.andar AS Andar,
funcionario.nome AS Funcionario FROM Setor 
JOIN Funcionario ON setor.idSetor = funcionario.fkSetor;

  
SELECT setor.nome AS Setor,
setor.andar AS Andar,
funcionario.nome AS Funcionario FROM Setor 
JOIN Funcionario ON setor.idSetor = funcionario.fkSetor
	WHERE setor.nome = 'Desenvolvimento';


SELECT * FROM Setor JOIN Funcionario 
	ON setor.idSetor = funcionario.fkSetor
  JOIN Acompanhante ON funcionario.idFuncionario = acompanhante.fkFuncionario; 
  
  SELECT 
  funcionario.nome AS Funcionario,
  funcionario.telefone AS Contato,
  Acompanhante.nome AS Acompanhante,
  acompanhante.relacao AS Relacao FROM funcionario
  JOIN Acompanhante ON funcionario.idFuncionario = acompanhante.fkFuncionario; 
  
  SELECT 
  funcionario.nome AS Funcionario,
  funcionario.telefone AS Contato,
  Acompanhante.nome AS Acompanhante,
  acompanhante.relacao AS Relacao FROM funcionario
  JOIN Acompanhante ON funcionario.idFuncionario = acompanhante.fkFuncionario 
		WHERE funcionario.nome = 'Rayane'; 


SELECT * FROM Setor JOIN Funcionario 
	ON setor.idSetor = funcionario.fkSetor
  JOIN Acompanhante ON funcionario.idFuncionario = acompanhante.fkFuncionario; 
  
  
SELECT 
funcionario.nome AS Funcionario,
Acompanhante.nome AS Acompanhante,
setor.nome AS Setor,
setor.andar AS Andar FROM Setor 
JOIN Funcionario ON setor.idSetor = funcionario.fkSetor 
	JOIN Acompanhante ON funcionario.idFuncionario = acompanhante.fkFuncionario; 
    
  
-- EXERCICIO 4 ///////////////////////////////////////////////////////////////

CREATE DATABASE Treinador_banco;
USE Treinador_banco;

CREATE TABLE Treinador (
idTreinador INT PRIMARY KEY,
nome VARCHAR(45) NOT NULL,
telefone CHAR(13) NOT NULL,
email VARCHAR(45) NOT NULL,
fkOrientador INT,
CONSTRAINT TreinadorNovato FOREIGN KEY (fkOrientador) REFERENCES Treinador (idTreinador)
);


INSERT INTO Treinador VALUES 
(1, 'Rayane', '11 96525-1111', 'raygrs@gmail.com', null), -- ORIENTADOR
(2, 'Julia', '11 96525-1112', 'Julia@gmail.com', null ), -- ORIENTADOR
(3, 'mariah', '11 96525-1113', 'Julia@gmail.com', 2), 
(4, 'beyonce', '11 96525-1114', 'beyonce@gmail.com', 1),  
(5, 'rhianna', '11 96525-1113', 'rhianna@gmail.com', 1),
(6, 'Ludmila', '11 96525-1112', 'Ludmila@gmail.com', 2),
(7, 'Iza', '11 96525-1111', 'Iza@gmail.com', null), -- ORIENTADOR
(8, 'Mellanie', '11 96525-1110', 'Mellanie@gmail.com', 7); 


CREATE TABLE Nadador (
idNadador INT NOT NULL,
nome VARCHAR(45) NOT NULL,
estadoNatal VARCHAR(45) NOT NULL,
dtNasc VARCHAR(45) NOT NULL,
fkTreinador INT NOT NULL,
CONSTRAINT treinador_nadador FOREIGN KEY (fkTreinador) REFERENCES Nadador (idNadador),
CONSTRAINT pkCommposta_nadador PRIMARY KEY (idNadador, fkTreinador)
);

-- QUANDO A CHAVE PRIMARIA É COMPOSTA A FK NUNCA PODERÁ SER NULA 
INSERT INTO NADADOR VALUES 
(1, 'Bianca', 'Bahia', '2000-09-08', 1),
(2, 'Vitória', 'Rio grande do sul', '2000-09-07', 1),
(3, 'Manuela', 'São paulo', '2000-09-04', 2),
(4, 'Stelar', 'Rio de janeiro', '2000-09-01', 2),
(5, 'Zoe', 'Porto rico', '2000-09-09', 3),
(6, 'Beatriz', 'Rio de janeiro', '2000-09-02', 4),
(7, 'Lua', 'São paulo', '2000-09-01', 5),
(8, 'Melinda', 'São paulo', '2000-09-11', 6),
(9, 'Sol', 'São paulo', '2000-08-06', 7),
(10, 'Pandora', 'São paulo', '2000-07-04', 8);

SELECT * FROM Nadador;
SELECT * FROM Treinador;

-- QUANDO FOR DAR O UPDATE OU DELETE SE UTILIZA O AND 
UPDATE Treinador SET nome = 'Rayane' WHERE idNadador =  1 AND idTreinador = 2;

SELECT * FROM Treinador JOIN Nadador 
	ON treinador.idtreinador = Nadador.fkTreinador;
    
SELECT * FROM Treinador JOIN Nadador 
	ON treinador.idtreinador = Nadador.fkTreinador 
		WHERE treinador.nome = 'Rayane';
        
       -- ifnull(nome do campo, 'o que você quer que apareça') -> se esse campo for nulo aparece XPTO

SELECT 
orientador.nome AS Orientador,
orientador.telefone AS Contato,
orientador.email AS Email,
orientado.nome AS Orientado,
orientado.telefone AS Contato,
orientado.email AS Email
FROM Treinador AS orientado 
JOIN treinador AS Orientador  
	ON orientado.fkOrientador = orientador.idTreinador;


SELECT 
orientador.nome AS Orientador,
orientador.telefone AS Contato,
orientador.email AS Email,
orientado.nome AS Orientado,
orientado.telefone AS Contato,
orientado.email AS Email
FROM Treinador AS orientado 
JOIN treinador AS Orientador ON orientado.fkOrientador = orientador.idTreinador
WHERE orientador.nome = 'Rayane';


SELECT * FROM Treinador AS orientado 
JOIN Treinador AS orientador on orientado.fkOrientador = orientador.idTreinador 
JOIN Nadador ON orientado.idTreinador = nadador.fkTreinador;
    

SELECT 
orientador.nome AS Orientador,
orientador.telefone AS Contato,
orientador.email AS Email,
orientado.nome AS Orientado,
orientado.telefone AS Contato,
orientado.email AS Email,
nadador.nome AS Nadador 
FROM Treinador AS orientador JOIN Nadador ON orientador.idTreinador = nadador.fkTreinador 
JOIN treinador AS Orientado ON orientado.fkOrientador = orientador.idTreinador
WHERE orientador.nome = 'Rayane';


SELECT orientado.nome AS Orientado,
orientado.telefone AS Contato,
orientado.email AS Email,
orientador.nome AS Orientador,
orientador.telefone AS Contato,
orientador.email AS Email,
nadador.nome AS Nadador,
nadador.estadoNatal AS EstadoNatal FROM Treinador as orientador
JOIN Nadador ON orientador.idTreinador = nadador.fkTreinador
JOIN Treinador as orientado on orientado.fkOrientador = orientador.idTreinador 
    WHERE orientado.nome = 'Mellanie';
    
    -- where fkTreinador is null;
    

-- ME DESAFIANDO /////////////////////////////////////////////////////

CREATE TABLE Endereco (
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
cep VARCHAR(45),
numero VARCHAR(45),
complemento VARCHAR(45)
);

INSERT INTO Endereco VALUES 
(DEFAULT , '05883-260', '335', NULL);


CREATE TABLE Paciente (
idPaciente  INT,
nome VARCHAR(45),
fkEndereco_paciente INT,
CONSTRAINT endereco_paciente FOREIGN KEY (fkEndereco_paciente) REFERENCES Endereco (idEndereco),
CONSTRAINT pkPaciente PRIMARY KEY (idPaciente, fkEndereco_paciente)
);

INSERT INTO Paciente VALUES
(1, 'Rayane', 1);

CREATE TABLE Medico (
CRM INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45)
);

INSERT INTO Medico VALUES
(10, 'Malia');

CREATE TABLE Consulta (
fkPaciente  INT,
CONSTRAINT consulta_paciente FOREIGN KEY (fkPaciente) REFERENCES Paciente (idPaciente),
fkMedico INT,
CONSTRAINT consulta_medico FOREIGN KEY (fkMedico) REFERENCES Medico (CRM),
dataHoraConsuta DATETIME,
CONSTRAINT PKconsulta PRIMARY KEY (fkPaciente, fkMedico)
);

INSERT INTO Consulta VALUES 
(1, 10, '2024-04-11 19:00:00');

CREATE TABLE Contato (
idContato INT,
prefixo INT,
sufixo VARCHAR(45),
fkPaciente_contato  INT,
CONSTRAINT contato_paciente FOREIGN KEY (fkPaciente_contato) REFERENCES Paciente (idPaciente),
fkMedico_contato INT,
CONSTRAINT contato_medico FOREIGN KEY (fkMedico_contato) REFERENCES Medico (CRM),
CONSTRAINT PKconsulta PRIMARY KEY (idContato, fkPaciente_contato, fkMedico_contato)
);

INSERT INTO Contato VALUES
(1, '11', '97029-8460', 1, 10 );

CREATE TABLE Especialidade (
idEspecialidade INT,
nome VARCHAR(45),
fkMedico INT,
CONSTRAINT especialidade_medico FOREIGN KEY (fkMedico) REFERENCES Medico (CRM),
CONSTRAINT pkespecialidade PRIMARY KEY (idEspecialidade, fkMedico)
);

INSERT INTO Especialidade VALUES
(1, 'Gastro', 10);


SELECT * FROM CONTATO;
SELECT * FROM PACIENTE;
SELECT * FROM ENDERECO;
SELECT * FROM MEDICO;
SELECT * FROM ESPECIALIDADE;
SELECT * FROM CONSULTA;

-- CONSEGUI DE PRIMEIRAAAAAA

SELECT paciente.nome AS Paciente,
contato.sufixo AS Celular,
endereco.cep AS Cep,
consulta.dataHoraConsuta AS Consulta,
medico.nome AS Medico 
FROM Paciente 
JOIN Endereco ON Endereco.idEndereco = paciente.fkEndereco_paciente
JOIN Contato ON paciente.idPaciente = contato.fkPaciente_contato
JOIN consulta ON paciente.idPaciente = consulta.fkPaciente
JOIN medico ON medico.CRM = consulta.fkMedico 
JOIN especialidade ON medico.CRM = especialidade.fkMedico; 



