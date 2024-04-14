CREATE DATABASE desafio; 
USE desafio;

CREATE TABLE TUTOR(
idTutor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
sobrenome VARCHAR(45),
dtNasc DATE
);

INSERT INTO TUTOR (nome, sobrenome, dtNasc) VALUES
('Rayane', 'Reis', '2004-11-04'),
('Isadora', 'Nunes', '2005-04-16');

CREATE TABLE PET (
idPet INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
tipo VARCHAR(45),
raca VARCHAR(45),
cor VARCHAR(45),
dtNasc DATE,
fkDono int,
constraint pet_dono FOREIGN KEY (fkDono) REFERENCES TUTOR (idTutor),
fkMae int,
constraint pet_mae FOREIGN KEY (fkMae) REFERENCES PET(idPet)
);

INSERT INTO PET (nome, tipo, raca, cor, dtNasc) VALUES
('Scott', 'Cachorro', 'Maltês', 'Branco', '2019-08-26'),
('Pandora','Cachorro', 'Maltês', 'Branco', '2016-09-08'),
('Amora', 'Gato', 'Siamês', 'cinza', '2016-11-03'),
('Ameixa', 'Gato', 'Siamês', 'cinza', '2018-12-03'),
('Dudu', 'Gato', 'Siamês', 'branco', '2018-12-03');

SELECT * FROM PET;
SELECT * FROM TUTOR;

update pet set fkDono = 1 where idPet in (11,12);
update pet set fkDono = 2 where idPet in (13,14,15);

update pet set fkMae = 12 WHERE idPet = 11;
update pet set fkMae = 13 where idPet in (13,14,15);

SELECT * FROM PET JOIN TUTOR
	ON idTutor = fkDono;
    
SELECT 
pet.nome AS PET,
pet.tipo AS Tipo,
pet.raca AS Raca,
pet.cor AS Cor,
tutor.nome AS Responsável
FROM PET JOIN TUTOR
	ON idTutor = fkDono;
    
    
SELECT 
pet.nome AS PET,
tutor.nome AS Responsável
FROM PET JOIN TUTOR
	ON idTutor = fkDono;
    
    SELECT 
pet.nome AS PET,
pet.tipo AS Tipo,
pet.raca AS Raca,
pet.cor AS Cor,
tutor.nome AS Responsável
FROM PET JOIN TUTOR 
	ON idTutor = fkDono WHERE tutor.nome = 'Rayane';
    

-- SEGUNDA MODELAGEM ///////////////////////////////////////////////

CREATE TABLE EMPRESA (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
CNPJ CHAR(14),
endereco VARCHAR(45)
);

INSERT INTO EMPRESA VALUES 
(default, 'C6BANK', '09876543212314', 'AVENIDA PAULISTA'),
(default, 'BRADESCO', '09876543212315', 'RUA LOBOS'),
(default, 'ELERA', '09876543212316', 'RUA HADDOCK LOBOS');

CREATE TABLE FUNCIONARIOS (
idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
cargo VARCHAR(45),
fkSupervisor INT,
CONSTRAINT fkSupervisor_funcionario FOREIGN KEY (fkSupervisor) REFERENCES FUNCIONARIOS (idFuncionario),
fkEmpresa INT,
CONSTRAINT fkEmpresa_funcionarios FOREIGN KEY (fkEmpresa) REFERENCES EMPRESA (idEmpresa)
);

INSERT INTO FUNCIONARIOS VALUES
(DEFAULT, 'Rayane', 'Desenvolvedora full stack', null, 2),
(DEFAULT, 'Sophia', 'Desenvolvedora front end', null, 1),
(DEFAULT, 'Matheus', 'Desenvolvedora backend', null, 3),
(DEFAULT, 'Duda', 'QA', 1, 2),
(DEFAULT, 'Maria', 'QA', 2, 1),
(DEFAULT, 'Isabel', 'Desenvolvedora full stack', 3, 3);


SELECT * FROM EMPRESA JOIN FUNCIONARIOS
	ON idEmpresa = fkEmpresa;
    
SELECT empresa.nome AS EMPRESA,
funcionarios.nome AS FUNCIONARIO,
funcionarios.cargo AS CARGO FROM EMPRESA JOIN FUNCIONARIOS 
	ON empresa.idEmpresa = funcionarios.fkEmpresa;
    
    
SELECT empresa.nome AS EMPRESA,
funcionarios.nome AS FUNCIONARIO,
funcionarios.cargo AS CARGO FROM EMPRESA JOIN FUNCIONARIOS 
	ON empresa.idEmpresa = funcionarios.fkEmpresa WHERE empresa.nome = 'Bradesco';
    
    
-- TERCEIRA MODELAGEM ///////////////////////////////////////////////

CREATE TABLE ENDERECO(
idEndereco  INT PRIMARY  KEY  AUTO_INCREMENT,
pais VARCHAR(45),
estado VARCHAR(45),
cidade VARCHAR(45),
rua VARCHAR(45),
bairro VARCHAR(45),
numero VARCHAR(10),
complemento VARCHAR(45)
);

INSERT INTO ENDERECO VALUES
(DEFAULT, 'Brasil', 'São paulo', 'São paulo', 'Alzelino guerra', 'capão', '335', null),
(DEFAULT, 'Brasil', 'Bahia', 'Salvador', 'Alzelino guerra', 'capão', '335', null);

UPDATE ENDERECO SET numero = '338' WHERE idEndereco = 2;

SELECT * FROM ENDERECO;


CREATE  TABLE PESSOA (
idPessoa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
sobrenome VARCHAR(45),
dtNasc DATE,
fkSombra INT,
CONSTRAINT sombra_pessoa FOREIGN KEY (fkSombra) REFERENCES PESSOA (idPessoa),
fkEndereco INT,
CONSTRAINT enddereco_Pessoa FOREIGN KEY (fkEndereco) REFERENCES ENDERECO (idEndereco)
);

INSERT INTO  PESSOA VALUES 
(default, 'Rayane', 'Reis', '2004-11-04', 1, 1),
(default, 'Jorge', 'Lima', '2006-09-12', 2, 2);

SELECT  * FROM  PESSOA JOIN ENDERECO  
	ON idEndereco = fkEndereco ;
    
    SELECT  * FROM  PESSOA JOIN ENDERECO  
	ON idEndereco = fkEndereco JOIN PESSOA AS SOMBRA 
		ON PESSOA.fksombra = SOMBRA.idPessoa;
    
 SELECT  
 PESSOA.nome,
 PESSOA.fkSombra,
 ENDERECO.estado
 FROM  PESSOA JOIN ENDERECO  
	ON idEndereco = fkEndereco JOIN PESSOA AS SOMBRA 
		ON PESSOA.fksombra = SOMBRA.idPessoa;
 
 
 
  SELECT  
 PESSOA.nome,
 PESSOA.fkSombra,
 ENDERECO.estado
 FROM  PESSOA JOIN ENDERECO  
	ON idEndereco = fkEndereco JOIN PESSOA AS SOMBRA 
		ON PESSOA.fksombra = SOMBRA.idPessoa WHERE endereco.estado = 'São paulo';

    