USE musimundos;

/* 1. Modifique a tabela de artistas, adicione o campo userCreator varchar(50) e dateCreation datetime. 
Então faça o seguinte:

a) Crie um trigger que ao inserir um registro na tabela de artistas, 
o usuário que criou o registro seja adicionado à coluna userCreator. Dica: qual função usamos para obter o usuário?

b) Além disso, deve-se adicionar no campo dateCreation em que dia e em que horário foi inserido o registro.

c)Execute um insert na tabela de artistas e depois faça um select no último registro para ver os resultados. 
Qual usuário foi adicionado? */

SELECT 
    *
FROM
    artistas;

ALTER TABLE artistas 
ADD COLUMN userCreator VARCHAR(50),
ADD COLUMN dateCreation DATETIME;

DELIMITER //
CREATE TRIGGER artistas_before_insert
BEFORE INSERT ON artistas
FOR EACH ROW
BEGIN
    SET NEW.userCreator = CURRENT_USER();
    SET NEW.dateCreation = NOW();
END;
//

INSERT INTO artistas (id, nome) VALUES (276,'Lucas');

SELECT 
    *
FROM
    artistas
ORDER BY dateCreation DESC
LIMIT 1;

/* 2. Modifique a tabela de artistas, adicione o campo userModification varchar(50) e dateModification datetime. 
Então faça o seguinte:
	a) Crie um trigger que quando um registro for atualizado na tabela de artistas, o usuário que atualizou o registro seja 
adicionado à coluna userModification.

	b) Além disso, deve-se adicionar no campo dateMoficacion em que dia e em que horário foi realizada a execução.
    
	c) Execute uma atualização na tabela de artistas e selecione no último registro para ver os resultados. 
Qual foi o usuário  que modificou os dados? */

SELECT * FROM artistas;

ALTER TABLE artistas
ADD COLUMN userModification VARCHAR(50),
ADD COLUMN dateModification DATETIME;

DELIMITER //
CREATE TRIGGER artistas_before_update
BEFORE UPDATE ON artistas
FOR EACH ROW
BEGIN
	SET NEW.userModification = CURRENT_USER();
    SET NEW.dateModification = NOW();
END;
//

UPDATE artistas 
SET 
    nome = 'Gabriel'
WHERE
    id = 276;

SELECT 
    *
FROM
    artistas
ORDER BY dateModification DESC
LIMIT 1;

/* 3. Crie a tabela artista_historico com os campos: 
	id int,
    nome varchar(85), 
    rating double(3,1), 
    user varchar(50), 
    date datetime, 
    ação varchar(10).
*/
CREATE TABLE artista_historico (
    id INT,
    nome VARCHAR(85),
    rating DOUBLE(3,1), 
    user VARCHAR(50),
    date DATETIME, 
    acao VARCHAR(10)
);

/* 4. Crie um trigger que quando um registro for inserido na tabela artistas, um valor seja inserido na tabela 
artista_historico, com os mesmos valores de id, nome e rating, o usuário que executou a ação, o dia e horário de 
execução e , em ação, adicione o valor "Inserir" */
DELIMITER //
CREATE TRIGGER artista_insert
AFTER INSERT ON artistas
FOR EACH ROW
BEGIN
	INSERT INTO artista_historico (id, nome, user, date, acao) 
    VALUES (NEW.id, NEW.nome, CURRENT_USER(), NOW(), 'Inserir');
END;
//

INSERT INTO artistas (id, nome) VALUES (277, 'Bach');
INSERT INTO artistas (id, nome) VALUES (278, 'Beethoven');

SELECT 
    *
FROM
    artistas
ORDER BY id DESC
LIMIT 2;	

/* 5. Crie um trigger que quando for feita uma atualização de um registro na tabela artistas, seja inserido um 
valor na tabela artista_histórico, com os mesmos valores de id, nome e rating, o usuário que executou a ação, 
o dia e hora da execução e, em ação, adicionar o valor "Update" */
DELIMITER //
CREATE TRIGGER artista_update
AFTER UPDATE ON artistas
FOR EACH ROW
BEGIN
	INSERT INTO artista_historico (id, nome, user, date, acao) 
    VALUES (NEW.id, NEW.nome, CURRENT_USER(), NOW(), 'Update');
END;
//

UPDATE artistas 
SET 
    nome = 'Johann Bach'
WHERE
    id = 277;

UPDATE artistas 
SET 
    nome = 'Ludwig Beethoven'
WHERE
    id = 278;

SELECT 
    *
FROM
    artistas
ORDER BY id DESC
LIMIT 2;	

/* 6. Crie uma trigger que quando um registro for deletado na tabela artistas, seja inserido um valor na tabela 
artista_historico, com os mesmos valores de id, nome e rating, o usuário que executou a ação, o dia e hora da 
execução e, em ação, adicione o valor "Delete" */
DELIMITER //
CREATE TRIGGER artista_delete
AFTER DELETE ON artistas
FOR EACH ROW
BEGIN
	INSERT INTO artista_historico (id, nome, user, date, acao) 
    VALUES (NEW.id, NEW.nome, CURRENT_USER(), NOW(), 'Delete');
END;
//

DELETE FROM artistas 
WHERE
    id = 277;

SELECT 
    *
FROM
    artistas
ORDER BY id DESC
LIMIT 2;	

/* 7. Execute uma inserção, atualização e exclusão na tabela de artistas. Em seguida, faça um select na tabela 
artista_historico. */
INSERT INTO artistas (id, nome) VALUES (279, 'Mozart');

UPDATE artistas 
SET 
    nome = 'Wolfgang Mozart'
WHERE
    id = 279;

DELETE FROM artistas WHERE id = 279;

SELECT * FROM artista_historico;