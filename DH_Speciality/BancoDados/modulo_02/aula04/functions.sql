USE musimundos;

# Tabela: Músicas

/* 1. Crie uma função que solicite os milissegundos da tabela de músicas como parâmetros 
de entrada e que retorne as mesmas informações como resultado, mas com o formato de horas, 
minutos e segundos — sem milissegundos. 
Caso o parâmetro cidade esteja vazio, 00:00:00 deve ser retornado. */


/* 2. Invoque a função para obter as informações de todas as músicas do gênero rock, 
usando a função para mostrar sua duração. */

# Tabela: Clientes

/* 1. Crie uma função que receba o id de um cliente como parâmetro e retorne a quantidade de notas fiscais 
que o mesmo possui. */

DELIMITER $$
CREATE FUNCTION faturas_cliente (id_passado tinyint)
RETURNS tinyint
DETERMINISTIC
BEGIN
	RETURN (SELECT c.nome, COUNT(f.id) AS qtd_faturas FROM faturas INNER JOIN faturas f ON f.id = c.id WHERE id_cliente = f.id_cliente GROUP BY c.nome);
END;
$$

/* 2. Invoque a função para obter todos os clientes e seu número de faturas, usando a função criada acima. */

SELECT id, faturas_cliente(id) FROM clientes;