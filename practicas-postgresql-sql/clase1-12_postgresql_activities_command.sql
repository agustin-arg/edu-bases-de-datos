-- Ejercicio 1: Obtén el primer registro de la tabla de alumnos utilizando el estándar SQL
--              para limitar filas, sin usar la cláusula LIMIT.
SELECT * 
FROM platzi.alumnos
FETCH FIRST 1 ROWS ONLY;

-- Ejercicio 2: Recupera únicamente el primer registro de la tabla de alumnos utilizando
--              la cláusula específica de PostgreSQL/MySQL para limitar resultados.
SELECT * 
FROM platzi.alumnos
LIMIT 1;

-- Ejercicio 3: Genera un listado de los primeros 10 alumnos, asignando un número de fila
--              secuencial a cada uno, independientemente de su ID original.
SELECT * 
FROM (
	SELECT ROW_NUMBER() OVER() AS row_id, *
	FROM platzi.alumnos
) AS alumnos_with_row_num
LIMIT 10
;

-- Ejercicio 4: Encuentra los 2 alumnos con la colegiatura más baja, mostrando su ID,
--              nombre y el costo de la colegiatura, asegurando que no haya duplicados.
SELECT DISTINCT id, nombre, colegiatura
FROM platzi.alumnos
ORDER BY colegiatura ASC
LIMIT 2;

-- Ejercicio 5: Identifica el segundo valor de colegiatura más alto registrado en la tabla,
--              utilizando una subconsulta correlacionada para comparar los montos.
SELECT DISTINCT colegiatura
FROM platzi.alumnos AS a1
WHERE 2 = (                                 
    SELECT COUNT (DISTINCT colegiatura)     
    FROM platzi.alumnos a2                  
    WHERE a1.colegiatura <= a2.colegiatura 
          );                                  

-- Ejercicio 6: Muestra todos los registros que se encuentran en la segunda mitad de la tabla,
--              basado en el orden de sus IDs, calculando el desplazamiento dinámicamente.
SELECT *
FROM platzi.alumnos
ORDER BY alumnos.id 
OFFSET(
	SELECT COUNT(*)/2
	FROM platzi.alumnos
);

-- Ejercicio 7: Selecciona filas específicas de la tabla basándote en su posición física (número de fila)
--              en el conjunto de resultados, extrayendo las posiciones 1, 5, 10, 12, 15 y 20.
SELECT *
FROM (
	SELECT ROW_NUMBER() OVER () AS row_id, *
	FROM platzi.alumnos
	) AS alumnos_with_row 
WHERE row_id IN (1, 5, 10, 12, 15, 20) 
;

-- Nota sobre el error común:
-- SELECT ROW_NUMBER() OVER () AS row_id, *
-- FROM platzi.alumnos
-- WHERE row_id IN (1, 5, 10, 12, 15, 20); 
-- Esto falla porque el WHERE se ejecuta antes que la proyección del SELECT donde se crea row_id.

-- Ejercicio 8: Obtén la información de todos los alumnos cuyo tutor tenga el ID 30,
--              utilizando una subconsulta en la cláusula WHERE para filtrar los IDs.
SELECT *
FROM platzi.alumnos
WHERE id IN (
    SELECT id
    FROM platzi.alumnos
    WHERE tutor_id = 30
    )
;

-- Ejercicio 9: Lista todos los alumnos excepto aquellos asignados al tutor con ID 30,
--              excluyendo explícitamente sus IDs del conjunto de resultados.
SELECT *
FROM platzi.alumnos
WHERE NOT (id IN (
    SELECT id
    FROM platzi.alumnos
    WHERE tutor_id = 30
    ))
;