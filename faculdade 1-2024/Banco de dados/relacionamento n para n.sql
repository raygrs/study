-- Relacionamento N PARA N 

CREATE DATABASE relacionamento;
USE relacionamento;

CREATE TABLE Paciente (
idPaciente INT PRIMARY  KEY AUTO_INCREMENT,
nome VARCHAR(45)
) AUTO_INCREMENT = 100;

 INSERT INTO Paciente VALUES
 (DEFAULT, 'Rayane'),
 (DEFAULT, 'Mayara');

CREATE TABLE Medico (
idMedico INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45)
)AUTO_INCREMENT = 2000;

INSERT INTO Medico VALUES
(DEFAULT, 'Dra.Tayna'),
(DEFAULT, 'Dr.lucas');

CREATE TABLE Consulta (
idConsulta INT,
dtConsulta DATETIME,
fkPaciente INT,
CONSTRAINT paciente_consulta FOREIGN KEY (fkPaciente) REFERENCES Paciente (idPaciente),
fkMedico INT,
CONSTRAINT medico_consulta FOREIGN KEY (fkMedico) REFERENCES Medico (idMedico),
CONSTRAINT pkComposta PRIMARY KEY (idConsulta, fkPaciente, fkMedico)
);

SELECT * FROM MEDICO;

INSERT INTO Consulta (idConsulta, dtConsulta,fkPaciente,fkMedico) VALUES
(1, '2023-04-01', 100, 2000),
(2, '2023-01-09', 100, 2001),
(3, '2023-01-09', 101, 2000),
(4, '2023-01-09', 101, 2001);

SELECT * FROM Paciente JOIN consulta 
	ON idPaciente = fkPaciente
    JOIN medico ON idMedico = fkMedico;
    
SELECT COUNT(*) FROM Consulta;
SELECT max(valor) FROM CONSULTA;

ALTER TABLE CONSULTA ADD COLUMN Valor DECIMAL(3,2);

UPDATE CONSULTA  SET VALOR = 2.99 WHERE idConsulta = 1 AND fkPaciente = 100 AND fkMedico = 2000;
UPDATE CONSULTA  SET VALOR = 2.30 WHERE idConsulta = 2 AND fkPaciente = 100 AND fkMedico = 2001;
UPDATE CONSULTA  SET VALOR = 2.99 WHERE idConsulta = 3 AND fkPaciente = 101 AND fkMedico = 2000;
UPDATE CONSULTA  SET VALOR = 2.99 WHERE idConsulta = 4 AND fkPaciente = 101 AND fkMedico = 2001;

select * from consulta;

SELECT max(valor) FROM CONSULTA; -- PEGA O MAXIMO
SELECT min(valor) FROM CONSULTA; -- PEGA O VALOR MINIMO
SELECT COUNT(valor) FROM CONSULTA; -- CONTABILIZA QUANTOS CAMPOS TEM o numero de registros
SELECT AVG (valor) FROM CONSULTA; -- MÉDIA DOS VALORES
select sum(valor) FROM CONSULTA; -- SOMA OS VALORES
SELECT round(valor) FROM CONSULTA; -- ARREDONDA OS VALORES


-- CONTABILIZA A QUANTIDADE DE PACIENTE  ONDE O VALOR DA CONSULTA  É MAIOR OU IGUAL A MEDIA DO VALOR 
SELECT count(fkPaciente) FROM consulta 
	WHERE valor >= (select avg(valor) from consulta);
     




