-- Criação da base de dados e uso da base de dados --
CREATE DATABASE exame_teste;
USE exame_teste;

-- Criação das Tabelas --

CREATE TABLE tbl_alunos (
id_aluno INT AUTO_INCREMENT PRIMARY KEY,
nome_aluno VARCHAR (100),
dt_nasc_aluno DATE,
mensalidade_aluno DECIMAL (10,2),
aluno_ativo BOOL,
materia_aluno INT );

CREATE TABLE tbl_materias (
id_materia INT PRIMARY KEY,
nome_materia VARCHAR (100) );

CREATE TABLE tbl_professores (
id_professor INT AUTO_INCREMENT PRIMARY KEY,
nome_professor VARCHAR (100),
materia_professor INT);

-- Criação das Constraints e Foreign Keys -- 
ALTER TABLE tbl_alunos ADD CONSTRAINT FOREIGN KEY (materia_aluno)
REFERENCES tbl_materias (id_materia);
ALTER TABLE tbl_professores ADD CONSTRAINT FOREIGN KEY (materia_professor)
REFERENCES tbl_materias (id_materia);

-- Inserção dos Dados -- 
INSERT INTO tbl_materias (id_materia, nome_materia) VALUES
(101, 'Algoritmos'), (255, 'Sistemas Operacionais'),
(552, 'Desenvolvimento Mobile'), (769, 'Interface Humano-Computador'),
(998, 'Gestão de Projetos');
INSERT INTO tbl_professores (nome_professor, materia_professor) VALUES
('Adriana Pinto', 255), ('Marcos Oliveira', 101), 
('Renata Campos', 998), ('Leandro Vieira', 769),
('Cristiane Moura', 552);
INSERT INTO tbl_alunos (nome_aluno, dt_nasc_aluno, mensalidade_aluno,
aluno_ativo, materia_aluno) VALUES
('Lucas Pereira', '2002-05-18', '900.00', 1, 255),
('Camila Ramos', '2003-11-02', '750.00', 1, 552),
('Henrique Souza', '2001-07-29', '1100.00', 0, 101),
('Patrícia Lopes', '2000-03-14', '830.00', 1, 769),
('Rafael Mendes', '2004-09-07', '670.00', 1, 998),
('Daniela Cruz', '2002-12-21', '960.00', 0, 552),
('Thiago Barbosa', '2001-04-10', '1080.00', 1, 998);

-- Enunciado para criação do SELECT --

/* Exiba o nome dos alunos, nome da matéria, a mensalidade do aluno e 
o nome do professor. Mostre apenas alunos que não tenham a letra B no nome,
matérias que não comecem com a letra S, professores que não tenham o nome 
terminado em o. Mostre apenas os alunos ativos e que tenham mensalidade 
entre 835,99 e 10.000,00. Porém se o nome do aluno tiver a palavra CRUZ
ele pode aparecer. Organize os dados de modo que o aluno que gasta
menos com a mensalidade seja exibido por último.*/

-- Resolução da questão do SELECT --

SELECT tbl_alunos.nome_aluno, tbl_materias.nome_materia,
tbl_alunos.mensalidade_aluno, tbl_professores.nome_professor
FROM tbl_materias 
INNER JOIN tbl_alunos 
ON tbl_alunos.materia_aluno = tbl_materias.id_materia
INNER JOIN tbl_professores 
ON tbl_professores.materia_professor = tbl_materias.id_materia
WHERE tbl_alunos.nome_aluno NOT LIKE '%B%' AND
tbl_materias.nome_materia NOT LIKE 'S%' 
AND tbl_professores.nome_professor NOT LIKE '%o' 
AND tbl_alunos.aluno_ativo = 1 AND
mensalidade_aluno BETWEEN 835.99 AND 10000.00
OR tbl_alunos.nome_aluno LIKE '%CRUZ%'
ORDER BY tbl_alunos.mensalidade_aluno DESC;
