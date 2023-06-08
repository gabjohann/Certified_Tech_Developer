/* Utilizando o banco AdventureWorks */

USE adventureworks;

# WHERE

/* 1. Mostre as pessoas cuja segunda letra do sobrenome é "a"
    Tabela: Contact
    Campos: FirstName, MiddleName e LastName
*/
SELECT 
    FirstName, MiddleName, LastName
FROM
    contact
WHERE
    LastName LIKE '_a%';

/* 2. Mostre o título e o nome concatenado com o sobrenome das pessaos que têm como 'Title' 
os valores 'Mr.' e 'Ms'
    Tabela: Contact
    Campos: Title, FirstName, LastName
*/
SELECT 
    Title, CONCAT(FirstName, ' ', LastName) AS nomeCompleto
FROM
    contact
WHERE
    Title LIKE 'Mr.'
        OR contact.Title LIKE 'Ms.';

/* 3. Mostre os nome e o nr. de série dos produtos cujo número do produto começa com 'AR' ou 'BE' ou 'DC'.
    Tabela: Product
    Campos: Name, ProductNumber
*/
SELECT 
    Name, ProductNumber
FROM
    product
WHERE
    product.ProductNumber LIKE 'AR%'
        OR product.ProductNumber LIKE 'BE%'
        OR product.ProductNumber LIKE 'DC%';

/* 4.Mostrar pessoas cujos nomes têm um C como o primeiro caractere e o segundo caractere não é "O" nem "E". 
    Tabela: Contact
    Campos: ContactID, FirstName, LastName
*/
SELECT 
    ContactID,FirstName, LastName
FROM
    contact
WHERE
    contact.FirstName LIKE 'C%'
        AND contact.FirstName NOT LIKE '_O%'
        AND contact.FirstName NOT LIKE '_E%';

/* 5. Mostre todos os produtos cujo preço de tabela está entre 400 e 500
    Tabela: Product
    Campos: Name, ListPrice
*/
SELECT 
   Name, ListPrice
FROM
    product
WHERE
    ListPrice BETWEEN 400 AND 500; 

/* 6. Mostre todos os funcionários que nasceram entre 1960 e 1980 e cujos anos de nascimento sejam pares.
    Tabela: Employee
    Campos: EmployeeID, ContactID, Title, BirthDate
*/
SELECT 
    EmployeeID,
    ContactID,
    Title,
    BirthDate
FROM
    employee
WHERE
    BirthDate BETWEEN '1960-01-01 00:00:00' AND '1980-12-31 00:00:00';


# Operadores & Joins

/* 1. Mostre o código, data de entrada e horas de férias dos funcionários que entraram a partir do ano 2000.
    Tabela: Employee
    Campos: EmployeeID, Title, HireDate, VacationHours
*/
SELECT 
    EmployeeID, Title, HireDate, VacationHours
FROM
    employee
WHERE
    HireDate > '2000-01-01 00:00:00';

/* 2. Mostre o nome, número do produto, preço de tabela e o preço de tabela acrescido de 10% dos produtos ccomo uja data final de venda seja anterior a hoje.
    Tabela: Product
    Campos: Name, ProductNumber, ListPrice, SellEndDate
*/
SELECT 
    Name, ProductNumber, ListPrice * 1.1, SellEndDate
FROM
    product
WHERE
    SellEndDate < '2023-05-10 00:00:00'
ORDER BY ListPrice;


# Group BY

/* 1. Mostre o número de funcionários por ano de nascimento.
    Tabela: Employee
    Campo: BirthDate
*/
SELECT 
    COUNT(BirthDate) AS QTD_FUNCIONARIOS, BirthDate
FROM
    employee
GROUP BY BirthDate;

/* 2. Mostre o preço médio dos produtos por ano de início da venda.
    Tabela: Product
    Campos: productID, ListPrice, SellStartDate
*/
SELECT 
    COUNT(product.productID) AS PRODUTO_ID,
    AVG(product.ListPrice) AS PRECO_MEDIO,
    product.SellStartDate
FROM
    product
GROUP BY product.SellStartDate;

/* 3. Mostre os produtos e o total vendido de cada um deles, ordenados pelo total vendido.
    Tabela: SalesOrderDetail
    Campos: ProductID, LineTotal 
*/

/* 4.Mostre a média vendida por fatura.
    Tabela: SalesOrderDetail
    Campos: SalesOrderID, LineTotal
*/


# Having

/* 1. Mostre subcategorias para produtos que têm dois ou mais produtos que custam
menos de US$ 200.
    Tabela: Product
    Campos: ProductSubcategoryID, ListPrice
*/
SELECT 
    ProductSubcategoryID, ListPrice, COUNT(*) AS Count
FROM
    product
WHERE
    ListPrice < 200
GROUP BY ProductSubcategoryID , ListPrice
HAVING COUNT(*) >= 2
ORDER BY ListPrice;

/* 2.Mostre todos os códigos de subcategoria existentes juntamente com a quantidade de produtos cujo preço de tabela 
é superior a US$ 100 e o preço médio é inferior a US$ 300.
    Tabela: Product
    Campos: ProductID, ProductSubcategoryID, ListPrice
*/
SELECT 
    ProductSubcategoryID, COUNT(*)
FROM
    product
WHERE
    ListPrice > 100 AND ListPrice < 300
GROUP BY ProductSubcategoryID , ListPrice; 


# Joins

/* 1. Mostre os preços de venda dos produtos em que o valor é inferior ao preço de tabela recomendado para esse 
produto ordenado pelo nome do produto.
    Tabelas: SalesOrderDetail, Product
    Campos: ProductID, Name, ListPrice, UnitPrice
*/
SELECT 
    Name,
    ListPrice,
    salesorderdetail.UnitPrice
FROM
    product
        JOIN
    salesorderdetail ON SalesOrderID = salesorderdetail.SalesOrderDetailID
ORDER BY Name;

/* 2. Mostre todos os produtos que têm o mesmo preço. O código e o nome de cada um dos dois produtos e o preço de ambos devem ser apresentados em pares.
    Ordenar por preço decrescente.
    Tabela: Product
    Campos: ProductID, Name, ListPrice
*/
SELECT 
    ProductID, Name, ListPrice, COUNT(ListPrice) AS count
FROM
    product
GROUP BY ListPrice
ORDER BY ListPrice DESC;

/* 3. Mostre o nome dos produtos e fornecedores ordenados por nome de fornecedor
decrescente.
    Tabelas: Product, ProductVendor, Vendor
    Campos: Name, ProductID, vendorId, ProductSubcategoryID
*/
SELECT 
    product.Name AS ProductName, vendor.Name AS VendorName
FROM
    product
        INNER JOIN
    productvendor AS productVendor ON product.ProductID = productVendor.ProductID
        INNER JOIN
    vendor ON productVendor.VendorID = vendor.VendorID
ORDER BY vendor.Name DESC;

/* 4. Mostre todas as pessoas —nome e sobrenome— e se forem funcionários, mostre também o id de login, caso contrário, mostre null.
    Tabelas: Contact, Employee
    Campos: FirstName, LastName, LoginID
*/
SELECT 
    contact.FirstName, contact.LastName, employee.LoginID
FROM
    contact
        LEFT JOIN
    employee ON contact.ContactID = employee.ContactID;