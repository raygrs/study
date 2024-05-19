CREATE DATABASE pratica9;
USE pratica9;

CREATE TABLE Grupo (
idGrupo INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
descricao VARCHAR(45)
);

INSERT INTO Grupo VALUES
(DEFAULT, 'Vaccin Therm', 'Monitoramneto em transportes de vacina'),
(DEFAULT, 'Coffe Sense ', 'Monitoramneto em solos de café'),
(DEFAULT, 'Digital Therm', 'Monitoramento em datacenters ');

CREATE TABLE Aluno (
ra CHAR(8) PRIMARY KEY,
nome VARCHAR(45),
email VARCHAR(45),
fkGrupo INT,
CONSTRAINT grupoAluno FOREIGN KEY (fkGrupo) REFERENCES Grupo (idGrupo)
);

-- INSERINDO VALORES GRUPO 1
INSERT INTO Aluno VALUES
('01241013', 'Rayane', 'rayanegreis@sptech.school', 1),
('01241014', 'Isabelly', 'isa@sptech.school', 1),
('01241015', 'Carlos', 'carlos@sptech.school', 1),
('01241016', 'João', 'joao@sptech.school', 1),
('01241017', 'Lucas', 'lucas@sptech.school', 1),
('01241018', 'Anthony', 'anthony@sptech.school', 1);


-- INSERINDO VALORES GRUPO 2
INSERT INTO Aluno VALUES
('01241022', 'Sophia', 'Sophia@sptech.school', 2),
('01241023', 'Mayara', 'Mayara@sptech.school', 2),
('01241024', 'Matheus', 'Matheus@sptech.school', 2),
('01241025', 'Kauan', 'Kauan@sptech.school', 2),
('01241026', 'Vitor', 'Vitor@sptech.school', 2),
('01241027', 'Samuel', 'Samuel@sptech.school', 2);


-- INSERINDO VALORES GRUPO 3
INSERT INTO Aluno VALUES
('01241030', 'Marcos', 'rayanegreis@sptech.school', 2),
('01241031', 'Guilherme Lima', 'Guilhermel@sptech.school', 2),
('01241032', 'Guilherme Silva', 'Guilhermes@sptech.school', 2),
('01241033', 'Bryan Learis', 'Bryan@sptech.school', 2),
('01241034', 'César', 'cesar@sptech.school', 2),
('01241035', 'Jonatas', 'jonatas@sptech.school', 2);


CREATE TABLE Professor(
idProfessor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
disciplina VARCHAR(45)
)AUTO_INCREMENT = 10000;

INSERT INTO Professor VALUES 
(DEFAULT, 'Fernanda', 'Pesquisa e inovação'),
(DEFAULT, 'Brandão', 'Pesquisa e inovação');


CREATE TABLE Sprint (
fkProfessor INT,
CONSTRAINT professorSprint FOREIGN KEY (fkProfessor) REFERENCES Professor(idProfessor),
fkGrupo INT,
CONSTRAINT grupoSprint FOREIGN KEY (fkGrupo) REFERENCES Grupo(idGrupo),
dataHora DATETIME,
nota INT,
CONSTRAINT pkComposta PRIMARY KEY (fkProfessor, fkGrupo, dataHora)
);

INSERT INTO Sprint VALUES
(10000, 1, '2024-04-26 10:00:00', 10),
(10000, 2, '2024-04-26 11:00:00', 9),
(10000, 3, '2024-04-26 12:00:00', 8),
(10001, 1, '2024-04-27 10:00:00', 9),
(10001, 2, '2024-04-27 11:00:00', 10),
(10001, 3, '2024-04-27 12:00:00', 10);

SELECT * FROM Professor;
SELECT * FROM Aluno;
SELECT * FROM Grupo;
SELECT * FROM Sprint;

-- EXIBIR OS DADOS DOS GRUPOS E DADOS DOS SEUS RESPECTIVOS ALUNOS
SELECT * FROM Aluno JOIN Grupo 
	ON aluno.fkGrupo = Grupo.idGrupo;
    
SELECT aluno.nome AS Aluno,
aluno.email AS Email,
grupo.nome AS Grupo,
grupo.descricao
 FROM Aluno JOIN Grupo 
	ON aluno.fkGrupo = Grupo.idGrupo;
    
    -- EXIBIR OS DADOS DE UM DETERMINADO GRUPOS E DADOS DOS SEUS RESPECTIVOS ALUNOS
SELECT * FROM Aluno JOIN Grupo 
	ON aluno.fkGrupo = Grupo.idGrupo where grupo.nome = 'Vaccin Therm';
    
-- EXIBIR A MÉDIA DAS NOTAS ATRIBUIDAS AOS GRUPOS 
SELECT AVG(nota) FROM GRUPO JOIN SPRINT
	ON grupo.idGrupo = sprint.fkGrupo;
    
-- EXIBIR A NOTA MINIMA E A NOTA MAXIMA QUE FOI ATRIBUIDA AOS GRUPOS NO GERAL
SELECT max(nota) AS Maximo, min(nota) AS Minimo 
FROM GRUPO JOIN SPRINT ON grupo.idGrupo = sprint.fkGrupo;

-- EXIBIR A SOMA DAS NOTAS DADAS AOS GRUPOS NO GERAL
SELECT sum(nota) FROM GRUPO JOIN SPRINT 
	ON grupo.idGrupo = sprint.fkGrupo;
    
-- EXIBIR OS DADOS DOS PROFESSORES QUE AVALIARAM CADA GRUPO. OS DADOS DOS GRUPOS E DATA E O HORARIO DA AVALIACAO
SELECT * FROM Professor JOIN sprint ON professor.idProfessor = sprint.fkProfessor
JOIN grupo ON grupo.idGrupo = sprint.fkgrupo;

SELECT professor.nome AS Professor,
professor.disciplina AS Disciplina,
grupo.nome AS Grupo,
grupo.descricao AS Descricao,
sprint.dataHora AS Data,
sprint.nota AS Nota
FROM Professor JOIN sprint ON professor.idProfessor = sprint.fkProfessor
JOIN grupo ON grupo.idGrupo = sprint.fkgrupo ORDER BY nota ASC;

-- EXIBIR OS DADOS DOS PROFESSORES QUE AVALIARAM UM DETERMINADO GRUPO. OS DADOS DOS GRUPOS E DATA E O HORARIO DA AVALIACAO
SELECT * FROM Professor JOIN sprint ON professor.idProfessor = sprint.fkProfessor
JOIN grupo ON grupo.idGrupo = sprint.fkgrupo WHERE grupo.nome = 'Vaccin Therm';

SELECT professor.nome AS Professor,
professor.disciplina AS Disciplina,
grupo.nome AS Grupo,
grupo.descricao AS Descricao,
sprint.dataHora AS Data,
sprint.nota AS Nota
FROM Professor JOIN sprint ON professor.idProfessor = sprint.fkProfessor
JOIN grupo ON grupo.idGrupo = sprint.fkgrupo WHERE grupo.nome = 'vaccin therm' ORDER BY nota ASC  ;

-- EXIBIR OS NOMES DOS GRUPOS QUE FORAM AVALIADOS POR UMM DETERMINADO PROFESSOR 
SELECT grupo.nome AS Grupo,
professor.nome  AS Avaliador
FROM GRUPO join sprint ON grupo.idGrupo = sprint.fkGrupo
JOIN professor ON professor.idProfessor = sprint.fkProfessor WHERE professor.nome = 'Fernanda';

-- EXIBIR OS DADOS DOS GRUPOS, DOS ALUNOS E OS DADOS DOS PROFESSORES QUE AVALIARAM JUNTO COM A DATA E HORARIO 
SELECT * FROM Grupo JOIN Aluno ON Grupo.idGrupo = aluno.fkGrupo
JOIN sprint on grupo.idGrupo = sprint.fkGrupo JOIN Professor ON
professor.idProfessor = sprint.fkProfessor;

SELECT grupo.nome AS Grupo,
grupo.descricao AS Descricao,
aluno.nome AS Aluno,
sprint.dataHora,
professor.nome AS Professor FROM Grupo JOIN Aluno ON Grupo.idGrupo = aluno.fkGrupo
JOIN sprint on grupo.idGrupo = sprint.fkGrupo JOIN Professor ON
professor.idProfessor = sprint.fkProfessor;

-- EXIBIR A QUANTIDADE DE NOTAS DISTINTAS
SELECT count(DISTINCT (nota)) FROM Sprint;

-- EXIBIR A IDENTIFICAÇÃO DO PROFESSOR A MÉDIA DAS NOTAS E SOMA DAS NOTAS AGRUPADAS POR GRUPO
SELECT professor.idprofessor,
avg(nota) AS Media,
sum(nota) AS Soma FROM Sprint join professor ON sprint.fkProfessor = professor.idProfessor
Group by professor.idProfessor;

-- EXIBIR A IDENTIFICAÇÃO DO GRUPO A MÉDIA DAS NOTAS E SOMA DAS NOTAS AGRUPADAS POR GRUPO
SELECT grupo.idGrupo AS Grupo,
avg(nota) AS Media,
sum(nota) AS Soma FROM Sprint join grupo ON sprint.fkGrupo = grupo.idGrupo
Group by grupo.idGrupo;

-- EXIBIR A IDENTIFICAÇÃO DO PROFESSOR A MENOR NOTAS E A MAIOR NOTAS AGRUPADAS POR PROFESSOR
SELECT professor.idprofessor,
min(nota) AS Menor,
max(nota) AS Maior
FROM Sprint join professor ON sprint.fkProfessor = professor.idProfessor
Group by professor.idProfessor;

-- EXIBIR A IDENTIFICAÇÃO DO GRUPO A MENOR NOTAS E A MAIOR NOTAS AGRUPADAS POR GRUPO
SELECT grupo.nome,
min(nota) AS Menor,
max(nota) AS Maior
FROM Sprint join grupo ON sprint.fkgrupo = grupo.idGrupo
Group by grupo.idGrupo;





