CREATE DATABASE AlunoProjeto;
USE AlunoProjeto;

CREATE TABLE Projeto (
idProjeto INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
descricao VARCHAR(500)
);

CREATE TABLE Aluno (
ra char(8) PRIMARY KEY,
nome VARCHAR(45),
telefone VARCHAR(13),
fkProjeto INT,
CONSTRAINT projeto_aluno FOREIGN KEY (fkProjeto) REFERENCES Projeto (idProjeto),
fkRepresentante char(8),
CONSTRAINT representante_aluno foreign key (fkRepresentante) REFERENCES Aluno (ra)
);

CREATE TABLE Acompanhante (
idAcompanhante INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
relacao VARCHAR(45),
fkAluno char(8),
CONSTRAINT acompanhante_aluno FOREIGN KEY (fkAluno) REFERENCES Aluno (ra)
);

INSERT INTO Projeto VALUES
(DEFAULT, 'Vaccin Therm', 'Monitoramento d etemperatura e umidade nos transportes de vacina'),
(DEFAULT, 'Coffe Sense', 'Monitoramento d etemperatura e umidade nos solos de café'),
(DEFAULT, 'Digital Therm', 'Monitoramento d etemperatura e umidade nos datacenters');


INSERT INTO Aluno VALUES
('01241013', 'Rayane', '11 96525-8913', 1, null),
('01241014', 'Meli', '11 96525-8917', 2, null),
('01241015', 'Alice', '11 96525-8916', 3, '01241014'),
('01241017', 'Mayra', '11 96525-8913', 1, '01241013'),
('01241011', 'Aline', '11 96525-8910', 1, '01241013');

INSERT INTO Acompanhante Values 
(DEFAULT, 'Jeane', 'Mãe', '01241013'),
(DEFAULT, 'vilena', 'avó', '01241014'),
(DEFAULT, 'ketlen', 'irmã', '01241015'),
(DEFAULT, 'vitoria', 'Mãe', '01241017');

select * from Projeto;
select * from acompanhante;
select * from aluno;

SELECT * FROM Aluno JOIN Projeto 
	ON projeto.idProjeto = Aluno.fkProjeto;
    
SELECT * FROM Aluno JOIN Acompanhante
	ON aluno.ra = Acompanhante.fkAluno;
    
SELECT * FROM Aluno JOIN Aluno as Representante 
	ON Aluno.fkRepresentante =  Representante.ra;

SELECT * FROM Aluno JOIN Projeto 
	ON projeto.idProjeto = Aluno.fkProjeto WHERE projeto.nome = 'Vaccin Therm' ;
    
SELECT * FROM Aluno JOIN Projeto 
	ON aluno.fkProjeto = Projeto.idProjeto JOIN Acompanhante
		ON Aluno.ra = Acompanhante.fkAluno;
	
    
-- SELECT MAIS ELABORADO PARA TREINAR LEFT JOIN
SELECT Aluno.nome AS Aluno,
Projeto.nome AS Projeto,
Projeto.descricao AS Segmento,
Acompanhante.nome AS Acompanhante,
Acompanhante.relacao AS Relacao
 FROM Aluno JOIN Projeto 
	ON aluno.fkProjeto = Projeto.idProjeto JOIN Acompanhante
		ON Aluno.ra = Acompanhante.fkAluno;
        
SELECT Aluno.nome AS Aluno,
Projeto.nome AS Projeto,
Projeto.descricao AS Segmento,
Acompanhante.nome AS Acompanhante,
Acompanhante.relacao AS Relacao,
Representante.nome AS Representante
FROM Aluno JOIN Projeto ON aluno.fkProjeto = Projeto.idProjeto 
LEFT JOIN Acompanhante ON Aluno.ra = Acompanhante.fkAluno 
LEFT JOIN Aluno AS Representante ON Aluno.fkRepresentante = Representante.ra;



-- EXERCICIO 2 //////////////////////////////////////////////////////

CREATE DATABASE Campanha;
USE Campanha;

CREATE TABLE Organizador (
idOrganizador INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
rua VARCHAR(45),
bairro VARCHAR(45),
email VARCHAR(45),
fkExperiente INT,
CONSTRAINT organizador_experiente FOREIGN KEY (fkExperiente) REFERENCES Organizador (idOrganizador) 
) AUTO_INCREMENT = 30;

CREATE TABLE Campanha (
idCampanha INT PRIMARY KEY AUTO_INCREMENT,
categoria VARCHAR(45),
instituicao1 VARCHAR(45),
instituicao2 VARCHAR(45),
dtFinal DATE,
fkOrganizador INT,
CONSTRAINT organizador_campanha FOREIGN KEY (fkOrganizador) REFERENCES Organizador (idOrganizador) 
)AUTO_INCREMENT = 500;
	
INSERT INTO Organizador VALUES
(DEFAULT, 'João', 'Cristalina', 'jd.thomas', 'joao@gmail.com', null),
(DEFAULT, 'Mary', 'Crispo', 'jd.thomas', 'Mary@gmail.com', null),
(DEFAULT, 'Luana', 'Antonio guerra', 'capão redondo', 'luana@gmail.com', 30),
(DEFAULT, 'josé', 'Aurora', 'interlagos', 'jose@gmail.com', 31),
(DEFAULT, 'Luara', 'Aurora maria', 'jd.Ângela', 'luara@gmail.com', 31);


INSERT INTO Campanha (categoria, instituicao1, instituicao2, dtFinal, fkOrganizador)VALUES
('Alimento', 'Bom prato', 'Associação de crianças carentes', '2024-02-20', 30),
('Doação de brinquedos', 'AACD', 'Criança esperança', '2024-02-20', 31),
('Doação de roupas', 'SASF', 'Associação de crianças carentes', '2022-02-10', 32 ),
('Auxilio emergencial', 'Associação do bem', 'Associação moradia', '2024-02-20', 33),
('Apoio emocional', 'Associação do bem', 'Associação bem estar', '2024-02-20', 33);


SELECT * FROM Organizador;
SELECT * FROM Campanha;

SELECT * FROM Organizador JOIN Campanha 
	ON organizador.idOrganizador = campanha.fkOrganizador;
    
SELECT * FROM Organizador JOIN Campanha 
	ON organizador.idOrganizador = campanha.fkOrganizador WHERE Organizador.nome = 'josé';
    
SELECT * FROM Organizador JOIN Organizador as Experiente
	ON experiente.idOrganizador = Organizador.fkExperiente;
    
SELECT * FROM Organizador JOIN Organizador as Experiente
	ON experiente.idOrganizador = Organizador.fkExperiente
    WHERE Experiente.nome = 'joão'; 
    
SELECT * FROM Organizador 
    JOIN Campanha ON Organizador.idOrganizador = Campanha.fkOrganizador
	left JOIN Organizador AS Experiente ON organizador.fkExperiente = experiente.idOrganizador;
    
SELECT * FROM Organizador 
    JOIN Campanha ON organizador.idOrganizador = campanha.fkOrganizador 
    JOIN Organizador AS Orientador ON organizador.fkExperiente = Orientador.idOrganizador;



