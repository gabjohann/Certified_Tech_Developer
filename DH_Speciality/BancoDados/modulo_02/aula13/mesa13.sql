USE adventureworks;

/* 1. Crie um índice FULLTEXT na tabela productdescription, utilizando como parâmetro a coluna 
`description`. */
CREATE FULLTEXT INDEX index_productDescription ON productdescription(description);

/* 2. Crie uma consulta que retorne o nome do modelo e a quantidade de vezes que a descrição 
“Suitable for any type of riding, on or off-road” aparece em cada modelo.
Em seguida, verifique as seguintes questões: 
	a) Quantos registros retornaram? 24
	b) Qual o tempo de duração dessa consulta? 0.015 sec
	c) Em quais modelos a descrição citada aparece mais de uma vez? 'Road-550-W' & 'Road-550'
*/
SELECT 
    model.`name` AS modelo,
    COUNT(product_description.ProductDescriptionID) AS quantidade
FROM
    productdescription product_description
        INNER JOIN
    productmodelproductdescriptionculture description_culture ON product_description.ProductDescriptionID = description_culture.ProductDescriptionID
        INNER JOIN
    productmodel model ON model.ProductModelID = description_culture.ProductModelID
WHERE
    MATCH (`description`) AGAINST ('Suitable for any type of riding, on or off-road.' )
GROUP BY model.`name`;

/* 3. Crie uma consulta que retorne a porcentagem de relevância da descrição 
“Suitable for any type of riding, on or off-road.”  para todos os modelos envolvidos.  
Em seguida, verifique as seguintes questões:
	a) Em qual modelo a descrição teve maior relevância? 'Mountain-500'
	b) Em qual modelo a descrição foi menos relevante? 'LL Road Rear Wheel'
	c) Qual o tempo de duração dessa consulta? 0.018 segundos
*/

SELECT 
    model.`name` AS modelo,
    FORMAT(MATCH (`description`) AGAINST ('Suitable for any type of riding, on or off-road. Fits any budget. Smooth-shifting with a comfortable ride.'),
        2) AS relevancia
FROM
    productdescription product_description
        INNER JOIN
    productmodelproductdescriptionculture description_culture ON product_description.ProductDescriptionID = description_culture.ProductDescriptionID
        INNER JOIN
    productmodel model ON model.ProductModelID = description_culture.ProductModelID
WHERE
    MATCH (`description`) AGAINST ('Suitable for any type of riding, on or off-road');

/* 4. Visualize todos os índices da tabela productdescription e responda:
	a) Em qual coluna está o índice clusterizado? 'ProductDescriptionID'
	b) Em qual coluna está o índice não clusterizado? 'Description'
	c) Qual o tipo de estrutura do índice clusterizado? 'BTREE'
	d) Qual o tipo de estrutura do índice não clusterizado? 'FULLTEXT'
*/
SHOW INDEX from productdescription;

/* 5. Acesse o  Schema Inspector do banco de dados AdventureWorks e responda:
	a) Qual o tamanho do banco de dados? 77.2 MiB
	b) Qual o tamanho da maior tabela desse banco de dados? 416 MiB
*/

/* 6. Acesse o Table Inspector da tabela productdescription e responda:
	a) Qual o tamanho estimado da tabela? 128 KiB
*/

/* 7. Selecione a guia Indexes e clique no índice  FULLTEXT. Responda:
	a) Qual a cardinalidade do índice criado? 762
	b) Justifique esse valor. Este valor corresponde a quantidade de valores únicos existentes na coluna indexada.
*/

/* 8. Exclua o índice FULLTEXT. */
ALTER TABLE productdescription DROP INDEX index_productDescription;