-- Ejercicio 1: Seleccionar alumnos con tutor_id entre 1 y 10 usando IN
SELECT *
FROM platzi.alumnos
WHERE tutor_id IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
;

-- Ejercicio 2: Seleccionar alumnos con tutor_id entre 1 y 10 usando operadores lógicos
SELECT *
FROM platzi.alumnos
WHERE tutor_id >= 1 AND tutor_id <= 10
;

-- Ejercicio 3: Seleccionar alumnos con tutor_id entre 1 y 10 usando BETWEEN
SELECT *
FROM platzi.alumnos
WHERE tutor_id BETWEEN 1 AND 10
;

-- Ejercicio 4: Verificar si el número 3 está dentro del rango [10, 20)
SELECT int4range(10, 20) @> 3
;

-- Ejercicio 5: Verificar si dos rangos numéricos se superponen
SELECT numrange(11.1, 22.2) && numrange(20.0, 30.0)
;

-- Ejercicio 6: Obtener el límite superior de un rango de enteros grandes
SELECT UPPER(int8range(15,25))
;

-- Ejercicio 7: Obtener el límite inferior de un rango de enteros grandes
SELECT LOWER(int8range(15,25))
;

-- Ejercicio 8: Verificar si la intersección de dos rangos es vacía
SELECT ISEMPTY((int4range(1,2)) * int4range(23, 25))
;

-- Ejercicio 9: Encontrar los números en común entre los id de tutor y carrera
SELECT numrange(
    (SELECT min(tutor_id) FROM platzi.alumnos),
    (SELECT max(tutor_id) FROM platzi.alumnos)
) * numrange(
    (SELECT min(carrera_id) FROM platzi.alumnos),
    (SELECT max(carrera_id) FROM platzi.alumnos)
);

