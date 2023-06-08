USE EMarket;

/* 1. Crie uma procedure que, dado o id do cliente, seja possível exibir os itens adquiridos na última 
compra daquele usuário. */
DELIMITER $$
CREATE PROCEDURE compras_usuario(IN idCliente CHAR(5))
BEGIN
SELECT 
    Clientes.Empresa AS cliente,
    MAX(Faturas.DataFatura) AS data_ultima_compra,
    Produtos.ProdutoNome AS nome_produto
FROM
    Faturas faturas
        JOIN
    Clientes clientes ON (faturas.ClienteID = clientes.ClienteID)
        JOIN
    DetalheFatura detalhe_fatura ON (faturas.FaturaId = detalhe_fatura.FaturaId)
        JOIN
    Produtos produtos ON (detalhe_fatura.ProdutoID = produtos.ProdutoID)
WHERE
    1 = 1 AND faturas.ClienteID = idCliente
GROUP BY faturas.ClienteID;
END
$$

DELIMITER $$
CALL compras_usuariO('ALFKI');
$$