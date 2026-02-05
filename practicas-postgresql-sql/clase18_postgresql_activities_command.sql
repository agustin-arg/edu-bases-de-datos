
-- Ejercicio :
SELECT	a.nombre,
		a.apellido,
		t.nombre,
		t.apellido
FROM	platzi.alumnos AS a
	INNER JOIN platzi.alumnos AS t ON a.tutor_id = t.id
;

-- Ejercicio :
SELECT	CONCAT(a.nombre, a.apellido) AS alumno,
		CONCAT(t.nombre, t.apellido) AS tutor
FROM	platzi.alumnos AS a
	INNER JOIN platzi.alumnos AS t ON a.tutor_id = t.id
;

-- Ejercicio :
SELECT	CONCAT(a.nombre, ' ', a.apellido) AS alumno,
		CONCAT(t.nombre, ' ', t.apellido) AS tutor
FROM	platzi.alumnos AS a
	INNER JOIN platzi.alumnos AS t ON a.tutor_id = t.id
;

-- Ejercicio :
SELECT	CONCAT(t.nombre, ' ', t.apellido) AS tutor,
		COUNT(*) AS cantidad_alumnos
FROM	platzi.alumnos AS a
	INNER JOIN platzi.alumnos AS t ON a.tutor_id = t.id
GROUP BY tutor
ORDER BY cantidad_alumnos DESC
;

-- Ejercicio : Sacar el promedio general de alumnos por tutor que existe
