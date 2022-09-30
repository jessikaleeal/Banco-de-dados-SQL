-- Parte 1 - 29-09-2022 / 03:25 - 03:51

-- adicionando uma linha em uma tabela
-- inserindo a lingua "português"

USE sakila;
SELECT * FROM sakila.language;

INSERTO INTO language
-- para inserir uma linha, precisa inserir um registro pra todas as colunas da tabela
-- DEFAULT: insere o dado de acordo com o último número
VALUES (DEFAULT, 'Portuguese', '2008-02-10 05:02:19')



-- ADICIONANDO MULTIPLAS LINHAS
SELECT * FROM sakila.language;

INSERTO INTO language
VALUES 
    (DEFAULT, 'Portuguese', '2008-02-10 05:02:19'),
    (DEFAULT, 'Spanish', '2009-02-10 05:02:19'),
    (DEFAULT, 'Polish', '2010-02-10 05:02:19')



-- INSERINDO DADOS EM MULTIPLAS TABELAS
SELECT * FROM sakila.city;

USE sakila;
-- inserindo o pais
INSERT INTO country
VALUES 
    (DEFAULT, 'Brazil2', '2035-02-15 04:44:19')

-- inserindo a cidade no pais criado
INSERT INTO city
VALUES 
-- inserindo o dado no que foi criado/ inserindo ele na última linha inserida
    (DEFAULT, 'Sao Paulo2', last_insert_id(), '2034-02-15 05:02:19')




-- COPIAR UMA TABELA COMPLETA
-- fazer o backup de uma TABELA
USE sakila;
CREATE TABLE payment_backup as
SELECT * FROM payment  




-- REMOVENDO UMA TABELA
DROP TABLE -- exclui toda a tabela e os dados dentro dela 

TRUNCATE TABLE -- exclui somente os dados de dentro da tabela


-- ATUALIZANDO UM VALOR (atualizar um field dentro de uma tabela/coluna)

UPDATE payment
SET 
    amount = 15.99
WHERE
    payment_id = 1


-- DELETANDO UM VALOR
DELETE FROM payment
WHERE   
    payment_id = 16049
    
    
-- Parte 2 - 30-09-2022 / 03:25 - 

-- FUNCTIONS
USE sakila

-- verificar qual é a maior MAX(), menor MIN() e a média AVG() de vendas
SELECT 
    MAX(amount),
    MIN(amount),
    AVG(amount)
FROM payment

-- mudar o título das colunas
SELECT 
    MAX(amount) AS Maior,
    MIN(amount) AS Menor,
    AVG(amount) AS 'Media de Valores'
FROM payment

-- quantas vendas fez, fazendo um filtro
-- pode usar para tirar relatórios

SELECT 
    SUM(amount) AS 'Total de Vendas',
    MAX(amount) AS Maior,
    MIN(amount) AS Menor,
    AVG(amount) AS 'Media de Valores'
    COUNT(amount) AS 'Numero de Vendas'
FROM payment
WHERE staff_id = 2


-- valor total que cada cliente gastou
-- agrupando pelo pagamento

SELECT 
    customer_id,
    SUM(amount) AS Total
FROM payment
GROUP BY customer_id
ORDER BY total DESC

-- ORDENANDO OS CLIENTES
-- pegar 10 clientes que mais compraram
-- puxar informação de duas tabelas
SELECT 
    cus.customer_id AS ID,
    cus.first_name AS Nome,
    cus.last_name AS Sobrenome
    SUM(amount) AS Total
    
FROM payment
JOIN customer cus USING(customer_id)

GROUP BY customer_id
ORDER BY Total DESC


-- lista dos clientes que compraram mais de $ 150

SELECT 
    cus.customer_id AS ID,
    cus.first_name AS Nome,
    cus.last_name AS Sobrenome
    SUM(amount) AS Total
    
FROM payment
JOIN customer cus USING(customer_id)

GROUP BY customer_id

HAVING Total >= 150

ORDER BY Total DESC


-- filtrar pela quantidade de compras que a pessoa fez
-- e mostrar qual comparam mais de 35 vezes

SELECT 
    cus.customer_id AS ID,
    cus.first_name AS Nome,
    cus.last_name AS Sobrenome
    SUM(amount) AS Total,
    COUNT(amount) AS 'Quantidade de Compras'
    
FROM payment
JOIN customer cus USING(customer_id)

GROUP BY customer_id

HAVING Total >= 150 AND 'Quantidade de Compras' >= 35

ORDER BY Total DESC
