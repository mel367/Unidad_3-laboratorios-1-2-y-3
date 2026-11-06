-- LAB-01 | Actividad 12


SELECT
    a.id_evento,
    a.momento,
    a.usuario_sesion,
    a.ip_cliente,
    d.key AS campo,
    a.valores_antes ->> d.key AS antes,
    d.value #>> '{}' AS despues
FROM auditoria.cambios_clientes AS a
CROSS JOIN LATERAL jsonb_each(a.valores_despues) AS d
WHERE a.operacion = 'UPDATE'
  AND a.valores_antes -> d.key IS DISTINCT FROM d.value
ORDER BY a.id_evento, d.key;

-- Resumen de eventos:
SELECT operacion, count(*) AS total
FROM auditoria.cambios_clientes
GROUP BY operacion
ORDER BY operacion;
