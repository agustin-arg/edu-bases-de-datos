-- Ejercicio 1: Extrae el año de incorporación de todos los alumnos para realizar un análisis de cohortes anuales.
SELECT EXTRACT(YEAR FROM fecha_incorporacion) AS anion_incorporacion
FROM platzi.alumno;

-- Alternativa:
SELECT DATE_PART('YEAR', fecha_incorporacion) AS anion_incorporacion
FROM platzi.alumnos;

-- Ejercicio 2: Desglosa la fecha de incorporación en sus componentes (año, mes, día, hora, minuto, segundo) para un análisis temporal detallado.
SELECT 
    id, nombre,
    DATE_PART('YEAR', fecha_incorporacion) AS year_incorporacion,
    DATE_PART('MONTH', fecha_incorporacion) AS month_incorporacion,
    DATE_PART('DAY', fecha_incorporacion) AS day_incorporacion,
    DATE_PART('HOUR', fecha_incorporacion) AS hour_incorporacion,
	DATE_PART('MINUTE', fecha_incorporacion) AS minute_incorporacion,
    DATE_PART('SECOND', fecha_incorporacion) AS second_incorporacion
FROM platzi.alumnos;

-- Ejercicio 3: Filtra y muestra únicamente a los alumnos que se incorporaron durante el año 2019.
SELECT *
FROM platzi.alumnos
WHERE (EXTRACT(YEAR FROM fecha_incorporacion)) = 2019
;

-- Alternativa:
SELECT *
FROM platzi.alumnos
WHERE (DATE_PART('YEAR', fecha_incorporacion)) = 2019
;

-- Ejercicio 4: Identifica a los alumnos que se inscribieron específicamente en Mayo de 2018.
SELECT *
FROM platzi.alumnos
WHERE (
(DATE_PART('YEAR', fecha_incorporacion)) = 2018 
AND (DATE_PART('MONTH', fecha_incorporacion) = 05)
)
;

-- Ejercicio 5: Detecta inconsistencias buscando registros que compartan el mismo ID dentro de la tabla de alumnos.
SELECT *
FROM platzi.alumnos AS ou
WHERE(
	SELECT COUNT(*)
	FROM platzi.alumnos AS inr
	WHERE ou.id = inr.id
)> 1 ;

-- Ejercicio 6: Agrupa los registros por su contenido completo (convertido a texto) para contar ocurrencias exactas de filas completas.
SELECT (platzi.alumnos.*)::text, COUNT(*)
FROM platzi.alumnos
GROUP BY platzi.alumnos.*
;

-- Ejercicio 7: Encuentra alumnos duplicados basándose en sus datos personales y académicos (ignorando el ID), ordenados por frecuencia de repetición.
SELECT (
	platzi.alumnos.nombre, --No se tiene en cuenta la columna id
	platzi.alumnos.apellido, 
	platzi.alumnos.email, 
	platzi.alumnos.colegiatura, 
	platzi.alumnos.fecha_incorporacion, 
	platzi.alumnos.carrera_id, 
	platzi.alumnos.tutor_id)::text, COUNT(*) AS Repetidos
FROM platzi.alumnos
GROUP BY platzi.alumnos.nombre, 
	platzi.alumnos.apellido, 
	platzi.alumnos.email, 
	platzi.alumnos.colegiatura, 
	platzi.alumnos.fecha_incorporacion, 
	platzi.alumnos.carrera_id, 
	platzi.alumnos.tutor_id
ORDER BY Repetidos DESC
;

-- Ejercicio 8: Muestra explícitamente los datos de los alumnos que aparecen más de una vez en el sistema.
SELECT (
	platzi.alumnos.nombre, 
	platzi.alumnos.apellido, 
	platzi.alumnos.email, 
	platzi.alumnos.colegiatura, 
	platzi.alumnos.fecha_incorporacion, 
	platzi.alumnos.carrera_id, 
	platzi.alumnos.tutor_id)::text, COUNT(*)
FROM platzi.alumnos
GROUP BY platzi.alumnos.nombre, 
	platzi.alumnos.apellido, 
	platzi.alumnos.email, 
	platzi.alumnos.colegiatura, 
	platzi.alumnos.fecha_incorporacion, 
	platzi.alumnos.carrera_id, 
	platzi.alumnos.tutor_id
HAVING COUNT(*) > 1
;

-- Ejercicio 9: Identifica los registros duplicados asignándoles un número de fila, marcando aquellos que son redundantes (row > 1).
SELECT *
FROM (
	SELECT id,
	ROW_NUMBER() OVER(
	PARTITION BY
		nombre,
		apellido,
		email,
		colegiatura,
		fecha_incorporacion,
		carrera_id,
		tutor_id
		ORDER BY id ASC
	) AS row, *
	FROM platzi.alumnos
) AS duplicados
WHERE duplicados.row > 1
;

-- Ejercicio 10: Ejecuta un proceso de limpieza de datos: verifica duplicados por email, identifica sus IDs y elimina los registros redundantes.

-- Paso 1: Certificar que existen correos duplicados.
SELECT email,COUNT(*)
FROM platzi.alumnos
GROUP BY email
HAVING COUNT(*) > 1;

-- Paso 2: Obtener el ID del correo duplicado (el que se considera redundante).
SELECT id 
FROM (
	SELECT id, ROW_NUMBER() OVER(PARTITION BY email ORDER BY id) AS row
	FROM platzi.alumnos
) AS duplicados
WHERE duplicados.row > 1;

-- Paso 3: Borrar el registro duplicado.
DELETE FROM platzi.alumnos
where id = (
SELECT id 
FROM (
	SELECT id, ROW_NUMBER() OVER(PARTITION BY email ORDER BY id) AS row
	FROM platzi.alumnos
) AS duplicados
WHERE duplicados.row > 1
);


-- Ejercicio 11:


-- Ejercicio 12:


-- Ejercicio 13:


-- Ejercicio 14:


-- Ejercicio 15:


-- Ejercicio 16:


-- Ejercicio 17:


-- Ejercicio 18:


-- Ejercicio 19: