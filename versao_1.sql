-- chamar a tabela
USE sakila;


-- selecionando dados da base
-- selecionando a coluna da tabela
SELECT actor_id, first_name FROM actor


-- listar todas as tabelas ao mesmo tempo
SELECT * FROM actor


-- ordenando por alguma coluna
-- não esquecer de usar o ponto e virgula
SELECT actor_id, first_name, last_name
FROM actor
ORDER BY first_name;


-- utilizando WHERE (filtrar qualquer linha dentro de uma coluna)
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id = 100
ORDER BY first_name;


-- utilizando WHERE (mostrar primeiras 10 entradas da tabela)
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id <= 10
-- ORDER BY first_name;


-- modificando uma coluna

USE sakila

SELECT 
    customer_id.
    amount
FROM payment


-- filtrando somente pelo cliente 1
SELECT 
    customer_id.
    amount
FROM payment
WHERE customer_id = 1


-- criar nova coluna reduzindo 10% do valor que ele comprou
-- trocando o nome da coluna
SELECT 
    customer_id.
    amount,
    amount - (amount * 0.10) AS discount
FROM payment
WHERE customer_id = 1


-- mostrar somente os valores que são iguais a 0.99
USE sakila;
SELECT * FROM payment
WHERE amount = 0.99


-- SABER QUEM PAGA MAIS ordenado
USE sakila;
SELECT * FROM payment
ORDER BY amount desc

-- filtrar todos os distritos que não sejam o TEXAS
USE sakila;
SELECT * FROM adress
WHERE district != 'Texas';


-- utilizando o AND
USE sakila;
SELECT * FROM custumer
-- pegando todos os clientes da loja nº 1 com o status inativo
WHERE store_id = 1 AND active = 0;


-- utilizando o OR
USE sakila;
SELECT * FROM payment
-- mostrando o funcionário nº 1 ou vendas de 1.99
WHERE staff_id = 1 OR amount = 1.99;


-- utilizando o OR
USE sakila;
SELECT * FROM payment
-- negando o funcionário nº 1 e mostrando vendas de 0.99 e custumer_id menor que 10
WHERE NOT staff_id = 1 AND amount = 0.99 AND customer_id < 10;


-- somente com um operador consegue filtrar multiplas entradas (OPERADOR IN)

USE sakila;
SELECT *
FROM address
WHERE district IN ('Alberta', 'Texas');

-- operador BETWEEN (entre um valor e outro)
-- mostrar o valor que a pessoa pagou entre (>=)1.99 e (<=)3.99
SELECT *
FROM payment
WHERE amount BETWEEN 1.99 AND 3.99;

-- operador LIKE
-- puxar todos os atores que iniciam com a letra 'A'
-- a letra pode ser maiuscula quanto minuscula
-- a% -> qualquer coisa que inicia com A
SELECT *
FROM actor
WHERE first_name LIKE 'A%';


-- operador IS NULL
-- ver onde os valores está vazio
SELECT *
FROM address
WHERE address2 IS NULL


-- operador LIMIT 
-- listar os 10 primeiros autores a partir do número 5
-- pula os 5 primeiros
SELECT * 
FROM actor
LIMIT 4, 10


-- operador REGEXP (expressão regular)
--  todos os autores que iniciam com a letra a e tenham D no nome
SELECT *
FROM actor
WHERE first_name REGEXP '^a|d'


-- operador REGEXP (expressão regular)
-- listar todos os autores que iniciam com a letra a e iniciam com D
SELECT *
FROM actor
WHERE first_name REGEXP '^a|^d'


-- operador REGEXP (expressão regular - regular expressions)
-- listar todos os autores que iniciam com a letra a e iniciam com D
-- [ge]a -> combinações que ele testa: ga/ ea 
SELECT *
FROM actor
WHERE first_name REGEXP '[ge]a'


-- OPERADORES MATEMATICOS
-- Só podem ser utilizados em colunas numéricas
SELECT nome, salario, salario*12 As salario_anual
FROM empregados


-- OPERADORES DE COMPARAÇÃO
-- O sinal de = cria um filtro na clausula. 
-- Os dados retornados deverão ser do código de empregado IGUAL a 12.
SELECT codigo_empregado, nome, salario
FROM empregados
WHERE codigo_empregado=12


-- OPERADORES LOGICOS
-- duas condições tenham de produzir um resultado único
-- empregado for do estado de SP e o seu salário maior que 2200
SELECT nome, salário, cidade, estado
FROM empregados
WHERE estado=***SP*** and salario > 2200


-- empregado for do estado de SP ou se o seu salário for maior que 2200.
SELECT nome, salário, cidade, estado
FROM empregados
WHERE estado=***SP*** or salario > 2200


-- verificar informações de 2 tabelas diferentes
SELECT *
-- tabelas customer e payment
FROM customer
JOIN payment ON customer.customer_id = payment.payment_id


-- filtrando somente algumas colunas do JOIN
SELECT 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name
    payment.rental_id,
    payment.amount
FROM customer
JOIN payment ON customer.customer_id = payment.payment_id


-- abreviando os nomes do filtro para o código ficar mais limpo
SELECT 
    cus.customer_id, 
    cus.first_name, 
    cus.last_name
    pay.rental_id,
    pay.amount
-- filtro sendo feito no nome da tabela / digita na frente do nome a abreviação    
FROM customer cus
JOIN payment pay ON cus.customer_id = pay.payment_id



-- utilizar o JOIN mais de uma vez
-- adicionar informação de 3 tabelas
SELECT 
    cus.customer_id, 
    cus.first_name, 
    cus.last_name,
    adr.address,
    pay.rental_id,
    pay.amount
    
FROM customer cus
JOIN payment pay 
    ON cus.customer_id = pay.payment_id
JOIN address adr 
    ON adr.customer_id = adr.address_id


-- INNER JOIN - se digitar só JOIN ele já é executado.
-- todos os registros tem que ser iguais nas duas tabelas
-- sempre olha da esquerda (LEFT) para a direita (RIGHT)
-- Está mostrando uma quantidade 

-- LEFT - quer que mostre todos os elementos que estão no lado esquerdo.
-- não importado se não tem nada do lado direito

-- RIGHT - quer que mostre todos os elementos que estão no lado direito.
-- não importando se não tem nada do lado esquerdo (pode ser vazio)
-- Exemplo dado: endereço nulo.

FROM customer cus
JOIN payment pay 
    ON cus.customer_id = pay.payment_id
LEFT JOIN address adr 
    ON adr.customer_id = adr.address_id
    


-- UNION 
-- pegar clientes que pagam mais que 10.99 e fazer eles virarem "VIP"
-- valores menores que 10.99 status de "NÃO VIP"
-- juntando a primeira parte com a segunda parte
SELECT 
    cus.customer_id, 
    cus.first_name, 
    cus.last_name,
    adr.address,
    pay.rental_id,
    pay.amount
    'VIP' as Status
    
FROM customer cus
JOIN payment pay 
    ON cus.customer_id = pay.payment_id
    WHERE pay.amount >= 10.99
    
UNION

SELECT 
    cus.customer_id, 
    cus.first_name, 
    cus.last_name,
    adr.address,
    pay.rental_id,
    pay.amount
    'VIP' as Status
    
FROM customer cus
JOIN payment pay 
    ON cus.customer_id = pay.payment_id
    WHERE pay.amount < 10.99;