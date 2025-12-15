
-- Ejercicio 1: Selecciona todos los clientes cuyo email contenga
--           el dominio 'hotmail'.

SELECT * FROM clients WHERE email LIKE '%hotmail%';



-- Ejercicio 2: Actualiza el número de teléfono del cliente con
--           ID = 1 a '+543492998754' y luego verifica que se
--           haya actualizado correctamente.

UPDATE clients SET phone_number = '+543492998754' WHERE client_id = 1 LIMIT 1;



-- Ejercicio 3: Actualiza el número de teléfono a NULL para todos
--           los clientes cuyo nombre contenga 'Laura' y luego
--           verifica los cambios.

UPDATE clients SET phone_number = NULL WHERE name LIKE '%Laura%';

SELECT client_id, name, phone_number FROM clients WHERE name LIKE '%Laura%';



-- Ejercicio 4: Obtén el ID, nombre, precio, stock e inversión total
--           (precio * stock) de los productos con precio <= 100
--           y stock > 8. Ordena por stock ascendente.

SELECT product_id, name AS 'Nombre de producto', price, stock, price * stock AS total 
FROM products 
WHERE price <= 100 AND stock > 8 
ORDER BY stock;



-- Ejercicio 5: Selecciona el ID, nombre, precio, stock e inversión
--           total de los 10 productos con mayor valor de
--           inversión (precio * stock).

SELECT product_id, name AS 'Nombre de producto', price, stock, price * stock AS total 
FROM products 
ORDER BY total DESC
LIMIT 10;



-- Ejercicio 6: Cuenta cuántos productos tienen un precio <= 100
--           y un stock > 8.

SELECT COUNT(*)
FROM products 
WHERE price <= 100 AND stock > 8;



-- Ejercicio 7: Cuenta cuántos productos tienen stock mayor a 0
--           (es decir, disponibles en inventario).

SELECT COUNT(*)
FROM products 
WHERE stock > 0;



-- Ejercicio 8: Calcula la cantidad total de unidades en stock
--           de todos los productos.

SELECT SUM(stock)
FROM products;



-- Ejercicio 9: Obtén el precio promedio de todos los productos.

SELECT AVG(price)
FROM products;



-- Ejercicio 10: Calcula la inversión total (SUM de precio * stock)
--           para todos los productos que tienen stock > 0.

SELECT SUM(price * stock)
FROM products
WHERE stock > 0;



-- Ejercicio 11: Selecciona 30 clientes aleatorios mostrando su email
--           y dos columnas indicadoras: una para Gmail (1 si es
--           @gmail.com, 0 si no) y otra para Hotmail ('¡AQUI!'
--           si es @hotmail.com, 0 si no).

SELECT 
    email, 
    if(email LIKE '%@gmail.com', 1, 0) AS 'Correos de Google', 
    if(email LIKE '%@hotmail.com', '¡AQUI!', 0) AS 'Correos de Microsoft'
FROM clients 
ORDER BY RAND() 
LIMIT 30;



-- Ejercicio 12: Crea una nueva tabla llamada 'investment' con los
--           siguientes campos:
--           - investment_id: ID único con autoincremento
--           - product_id: referencia al producto (requerido)
--           - investment: monto de inversión (por defecto 0)

CREATE TABLE investment (
    investment_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    product_id INTEGER UNSIGNED NOT NULL,
    investment INTEGER NOT NULL DEFAULT 0
);


-- Ejercicio 13: Inserta en la tabla 'investment' el cálculo de
--           inversión total para cada producto (stock * precio).

INSERT INTO investment(product_id, investment)
SELECT product_id, stock * Price FROM products;

--Ejercicio 14

SELECT * FROM investment
LEFT  JOIN products 
ON investment.product_id = products.product_id

--Ejercicio 15

SELECT * FROM investment
LEFT  JOIN products 
ON investment.product_id = products.product_id
WHERE investment > 40000
AND investment.product_id % 10 = 0 
--Como ambas tablas tienen la columna product_id 
--hay que espesificar a cual nos referimos con investment.product_id
ORDER BY investment;

--Ejercicio 16: Usar alias en tablas

SELECT p.product_id AS p_id, p.name, p.price, i.investment 
FROM investment AS i
LEFT  JOIN products AS p
ON i.product_id = p.product_id
WHERE i.investment > 40000
AND i.product_id % 10 = 0 
ORDER BY investment;

--Ejercicio 16: Usar alias en tablas

SELECT p.product_id AS p_id, p.name, p.price, i.investment 
FROM investment AS i
LEFT  JOIN products AS p
ON i.product_id = p.product_id
WHERE i.investment > 40000
AND i.product_id % 10 = 0 
ORDER BY investment;

--Ejercicio 16: Usar alias en tablas

SELECT p.product_id AS p_id, p.name, p.price, i.investment, 
ROUND(i.investment/ p.price) AS stock_calculado,
IF(ROUND(i.investment/ p.price) = p.stock, 'True', 'Error')
FROM investment AS i
LEFT  JOIN products AS p
ON i.product_id = p.product_id
WHERE i.investment > 40000
AND i.product_id % 10 = 0 
ORDER BY investment;