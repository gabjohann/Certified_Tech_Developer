USE musimundos;
/* 1. Crie uma consulta que retorne os clientes e faturas que possuem a data mínima da fatura 
gerada no ano de 2010. */

SELECT 
    fatura.data_fatura, SUM(fatura.total) AS valor_total
FROM
    clientes clientes
        INNER JOIN
    (SELECT 
        selecao_faturas.id_cliente AS id_clientes,
            selecao_faturas.data_fatura AS data_fatura,
            selecao_faturas.valor_total AS total
    FROM
        faturas selecao_faturas
    WHERE
        YEAR(selecao_faturas.data_fatura) = 2010) AS fatura ON fatura.id_clientes = clientes.id
GROUP BY fatura.data_fatura;