-- LAB-03 / Actividad 1: verificaciones de calidad
-- Ejecutar en la base comercial. No elimina ni corrige registros.

-- Posibles duplicados por correo normalizado
SELECT lower(correo) AS correo_normalizado,
       count(*) AS registros,
       string_agg(id::text, ', ' ORDER BY id) AS ids
FROM public.clientes
GROUP BY lower(correo)
HAVING count(*) > 1;

-- RFC ausente o con formato no válido (validación sintáctica de práctica)
SELECT id, nombre, rfc
FROM public.clientes
WHERE rfc IS NULL
   OR rfc !~ '^[A-ZÑ&]{3,4}[0-9]{6}[A-Z0-9]{3}$';

-- Correo con formato no válido
SELECT id, nombre, correo
FROM public.clientes
WHERE correo !~ '^[^@\s]+@[^@\s]+\.[^@\s]+$';

-- Edad fuera del rango operativo definido
SELECT id, nombre, edad
FROM public.clientes
WHERE edad IS NOT NULL AND (edad < 18 OR edad > 120);

-- Completitud
SELECT count(*) AS total,
       count(*) FILTER (WHERE telefono IS NULL) AS sin_telefono,
       count(*) FILTER (WHERE rfc IS NULL) AS sin_rfc
FROM public.clientes;

-- Nota: la expresión regular no verifica la existencia del RFC ante el SAT.
