-- CORREÇÃO DOS EXERCICIOS DESAFIOS 

USE ALUNOPROJETO;

CREATE TABLE PROJETO(
idProjeto INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
descricao VARCHAR(100)
);

INSERT INTO PROJETO VALUES
(default, 'coffeesense', 'Projeto dedicado ao monitoramento do solo de café'),
(default, 'vaccine therm', 'Projeto dedicado ao monitoramento da temperatura e umidade de vacinas'),
(default, 'Digital therm', 'Projeto dedicado ao monitoramento da temperatura e umidade de datacenters'),
(default, 'Vinholândia', 'Projeto dedicado ao monitoramento da temperatura e umidade de vinhos');

select * from projeto;


CREATE TABLE ALUNO(
ra CHAR(8) PRIMARY KEY, -- QUANDO É CHAR OU VARCHAR NÃO PODE SER AUTO_INCREMENT POIS E TEXTO E TEXTO NÃO É SEQUENCIAL
nome VARCHAR(45),
telefone VARCHAR(11), -- no telefone é legal colocar varchar para ser mais flexível
fkProjeto int,
constraint fkProjeto_aluno FOREIGN KEY (fkprojeto) REFERENCES PROJETO (idProjeto),
fkRepresentante CHAR(8),
CONSTRAINT fkRepresentante_aluno FOREIGN KEY (fkRepresentante) REFERENCES ALUNO (ra)
);
INSERT INTO ALUNO (ra, nome, telefone, fkprojeto, fkRepresentante) VALUES 
('01241001', 'Alberto', '912345678', 1, null),
('01241002', 'Bernado', '912345677', 1, '01241001'),
('01241003', 'Carlos', '912345676', 1, '01241001'),
('01241004', 'Daniel', '912345675', 2, null), -- como ele é representante não precisamos colocar a fkrepresentante
('01241005', 'Enzo', '912345674', 2, '01241004'),
('01241006', 'Fabricio', '912345673', 2, '01241004'),
('01241007', 'Gabriela', '912345672', 3, null),
('01241008', 'helena', '912345674', 3, '01241007'),
('01241009', 'Isis', '912345674', 3, '01241007');

select * from aluno;

-- EXIBIR OS DADOS DOS ALUNOS E DOS PROJETOS CORRESPONDENTES
SELECT * FROM ALUNO JOIN PROJETO 
	ON fkProjeto = idprojeto;
    
    
    -- EXIBIR OS DADOS DOS ALUNOS (REPRESENTADOS) E DOS SEUS RESPECTIVOS REPRESENTANTANTES - JOIN RECURSIVO
    
    -- ISSO É UM JOIN NORMAL SÓ QUE OS CAMPOS SERIAM OS MESMOS 
    
    SELECT * FROM ALUNO AS REPRESENTADOS 
		JOIN ALUNO AS REPRESENTANTES
		ON REPRESENTADOS.FKREPRESENTANTE = REPRESENTANTES.RA;
    
    -- NO ON SE EU NÃO COLOCAR A TABELA QUE APELIDEI PONTO O CAMPO DA FK VAI DAR ERRADO POIS COMO É 
    -- AUTORELACIONAMENTO AMBOS TEM O MESMO CAMPO, PRECISAMOS PEGAR O APELIDO.CAMPO QUE QUERO
    
    SELECT REPRESENTADO.NOME AS REPRESENTADO,
		REPRESENTANTE.NOME AS REPRESENTANTE
		FROM ALUNO AS REPRESENTADO JOIN ALUNO AS REPRESENTANTE 
			ON REPRESENTADO.fkRepresentante = REPRESENTANTE.ra;
    

-- EXIBIR OS DADOS OS ALUNOS E DOS PROJETOS CORRESPONDENTES MAS SOMENTE DE UM DETERMINADO PROJETO

SELECT * FROM ALUNO JOIN PROJETO 
	ON aluno.fkProjeto = projeto.idProjeto
		WHERE projeto.nome = 'coffeesense'; 
        
        -- APENAS COM O NOME 
        
        SELECT 
		aluno.nome AS Aluno,
        projeto.nome AS Projeto FROM ALUNO JOIN PROJETO 
			ON aluno.fkProjeto = projeto.idProjeto
				WHERE projeto.nome = 'coffeesense';
    
    
    -- EXERCICIO 2 ////////////////////////////////////////////
    
 CREATE DATABASE CAMPANHA;
 USE CAMPANHA;
 
 CREATE TABLE ORGANIZADOR (
 idOrganizador INT PRIMARY KEY AUTO_INCREMENT,
 nome VARCHAR(45),
 rua VARCHAR(45),
 bairro VARCHAR(45),
 email VARCHAR(264) UNIQUE
 )AUTO_INCREMENT = 30;
                
ALTER TABLE ORGANIZADOR ADD COLUMN fkOrientador int,
ADD CONSTRAINT fkOrientador_organizador FOREIGN KEY (fkOrientador) REFERENCES ORGANIZADOR (idOrganizador);

DESCRIBE ORGANIZADOR;

INSERT INTO ORGANIZADOR (nome, rua, bairro, email) VALUES
('ANA', 'Rua dos Alfeneiros', 'Cerqueira césar', 'ana@sptech.school'),
('Bruno', 'Rua Sésamo', 'Limoeiro', 'bruno@sptech.school'),
('Caio', 'Rua Baker', 'Barra Funda', 'caio@sptech.school'),
('Danilo', 'Avenida Brasil', 'Mooca', 'danilo@sptech.school');

SELECT * FROM ORGANIZADOR;

UPDATE ORGANIZADOR SET fkOrientador = 30 WHERE idOrganizador in (31,32);

CREATE TABLE CAMPANHA (
idCampanha INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
categoria VARCHAR(45),
instituicao1 VARCHAR(45),
instituicao2 VARCHAR(45),
dataFinal DATE
)AUTO_INCREMENT = 500;     


ALTER TABLE CAMPANHA ADD COLUMN fkOrganizador INT,
ADD CONSTRAINT ORGANIZADOR_CAMPANHA FOREIGN KEY (fkOrganizador) REFERENCES organizador(idOrganizador);

DESCRIBE CAMPANHA;

INSERT INTO Campanha (nome,categoria, instituicao1, instituicao2,dataFinal) VALUES
('TELETON', 'Financeira', 'AACD', 'GRAACC', '2023-08-01'),
('CRIANÇA ESPERANÇA', 'Alimento', 'UNESCO', 'UNICEF', '2023-08-01'); 


INSERT INTO Campanha (nome,categoria, instituicao1, instituicao2,dataFinal) VALUES
('Projeto feliz ', 'Financeira', 'Crianças do bem', 'Felicidade Absoluta', '2023-08-01');

SELECT * FROM CAMPANHA;

UPDATE CAMPANHA SET fkOrganizador = 30 WHERE idCampanha = 500;
UPDATE CAMPANHA SET fkOrganizador = 31 WHERE idCampanha = 501;

-- EXIBIR OS DADOS DOS ORGANIZADORES E OS DADOS DAS SUAS RESPECTIVAS CAMPANHAS

SELECT 
 campanha.fkOrganizador,
 campanha.nome AS 'Campanha',
 organizador.idOrganizador AS 'Organizador'
 FROM ORGANIZADOR JOIN CAMPANHA 
	ON campanha.fkOrganizador = organizador.idOrganizador;
    
    -- O SELECT SEM ON MOSTRA TODAS AS POSSIBILIDADES DE COMBINAÇÕES SIGA O EXEMPLO 
    SELECT 
 campanha.fkOrganizador,
 campanha.nome AS 'Campanha',
 organizador.idOrganizador AS 'Organizador'
 FROM ORGANIZADOR JOIN CAMPANHA ; 
 
 -- EXIBIR OS DADOS DE UM DETERMINADO ORGANIZADOR (INFORMAR NOME DO ORGANIZADOR NAS SUAS CONSULTAS )E SUAS RESPECTIVAS CAMPANHAS 

SELECT * FROM ORGANIZADOR JOIN CAMPANHA 
	on organizador.idOrganizador = campanha.fkorganizador 
		WHERE organizador.nome = 'ANA';
        
 -- Exibir os dados dos organizadores novatos e os dados dos respectivos organizadores orientadores.

SELECT * FROM ORGANIZADOR AS NOVATOS
JOIN ORGANIZADOR AS ORIENTADOR 
ON orientador.idOrganizador = novatos.fkOrientador;


-- Exibir os dados dos organizadores novatos e os dados dos respectivos organizadores orientadores,
-- porém somente de um determinado organizador orientador (informar o nome do organizador orientador na consulta)

SELECT * FROM ORGANIZADOR AS NOVATOS JOIN ORGANIZADOR AS EXPERIENTE 
	ON novatos.fkOrientador = experiente.idOrganizador where experiente.nome = 'ana';
    
    -- Exibir os dados dos organizadores novatos, os dados das respectivas campanhas
-- organizadas e os dados dos respectivos organizadores orientadores

SELECT * FROM ORGANIZADOR AS NOVATOS JOIN ORGANIZADOR AS EXPERIENTE 
	ON NOVATOS.fkOrientador = EXPERIENTE.idOrganizador
		JOIN CAMPANHA ON CAMPANHA.fkOrganizador = EXPERIENTE.idOrganizador;
        
        
	-- Exibir os dados de um organizador novato (informar o seu nome na consulta), 
-- os dados das respectivas campanhas em que trabalha e os dados do seu organizador orientador.

SELECT * FROM ORGANIZADOR AS NOVATOS JOIN ORGANIZADOR AS ORIENTADOR 
	ON NOVATOS.fkOrientador = ORIENTADOR.idOrganizador 
		JOIN CAMPANHA ON campanha.fkOrganizador = orientador.idOrganizador WHERE novatos.nome = 'Bruno';
        
        
        SELECT * FROM CAMPANHA;
        
        UPDATE CAMPANHA SET fkOrganizador = 31 where idCampanha = 502;

	
    
    
    
    
    
