/* 
1. A empresa NetFilmes deseja que, quando um novo usuário se cadastrar no seu site, 
uma função calcule sua idade e uma procedure liste os filmes referentes ao gênero indicado para a idade.
Uma dica: Você já criou uma função para calcular a idade. Basta copiá-la e executar no banco conteudos.
*/

SELECT * FROM conteudos.generos;
SELECT * FROM conteudos.usuarios;

DELIMITER $$
CREATE FUNCTION conteudos.f_obter_idade (birth date) RETURNS TINYINT  
DETERMINISTIC
BEGIN
    DECLARE age TINYINT;
    SET age = (SELECT timestampdiff(year,birth, curdate()));
    RETURN age;
END
$$

DELIMITER $$
CREATE PROCEDURE conteudos.usp_mostra_conteudo (p_id INT)
BEGIN
    DECLARE dt_nasc DATE;

    SET dt_nasc = (SELECT data_nascimento FROM conteudos.usuarios WHERE id = p_id);

SELECT 
    f.titulo, g.nome, g.idade
FROM
    conteudos.filmes f
        INNER JOIN
    conteudos.filme_genero AS fg ON f.filme_id = fg.filme_id
        INNER JOIN
    conteudos.generos g ON fg.genero_id = g.genero_id
WHERE
    g.idade <= CASE
        WHEN conteudos.f_obter_idade(dt_nasc) BETWEEN 0 AND 9 THEN 9
        WHEN conteudos.f_obter_idade(dt_nasc) BETWEEN 10 AND 17 THEN 17
        WHEN conteudos.f_obter_idade(dt_nasc) BETWEEN 18 AND 25 THEN 25
        WHEN conteudos.f_obter_idade(dt_nasc) BETWEEN 26 AND 40 THEN 40
        WHEN conteudos.f_obter_idade(dt_nasc) > 40 THEN 50
        ELSE 55
    END;
END
$$

DELIMITER $$
CALL conteudos.usp_mostra_conteudo (1);
$$

/*
2. É solicitado, ainda, que seja criada uma procedure que, dado o id de um cliente, 
seja possível exibir o tipo de plano de assinatura, o número de parcelas, 
a data de vencimento e o valor de cada parcela.
*/

PROCEDURE fn_diaUtil
DELIMITER $$
CREATE FUNCTION fn_diaUtil(data1 date) RETURNS DATE
DETERMINISTIC
BEGIN
DECLARE diaUtil DATE;
IF weekday(data1) < 5 THEN
SET diaUtil= data1;
ELSEIF weekday(data1)=5 THEN
#é sabado
SET diaUtil= date_add(data1,INTERVAL 2 DAY);

ELSE

#é domingo
SET diaUtil= date_add(data1,INTERVAL 1 DAY);

END IF;
RETURN diaUtil;
END $$
DELIMITER ;

/*
3. Gere uma procedure que insira os dados da tabela temporária na tabela assinaturas. 
Para isso, siga o que se pede:

	a)crie uma procedure que receberá os dados da tabela temporária e realizará o insert na tabela assinaturas.

	b)crie uma procedure com um cursor que receberá os dados de cada linha da tabela temporária e chamará 
	a procedure anterior para inserir os dados.
*/