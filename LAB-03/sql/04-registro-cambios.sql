-- LAB-03 / Actividad 7: registro mínimo de solicitudes de cambio
-- Revisar primero si el esquema/tabla ya existen.
CREATE SCHEMA IF NOT EXISTS gobierno;
REVOKE ALL ON SCHEMA gobierno FROM PUBLIC;

CREATE TABLE IF NOT EXISTS gobierno.solicitudes_cambio (
    folio            TEXT PRIMARY KEY,
    descripcion      TEXT NOT NULL,
    solicitado_por   TEXT NOT NULL,
    aprobado_por     TEXT,
    ambiente         TEXT NOT NULL
                     CHECK (ambiente IN ('desarrollo', 'pruebas', 'produccion')),
    fecha_aprobacion TIMESTAMPTZ,
    ventana_inicio   TIMESTAMPTZ,
    ventana_fin      TIMESTAMPTZ,
    CHECK (ventana_fin IS NULL OR ventana_inicio IS NULL OR ventana_fin > ventana_inicio)
);

COMMENT ON TABLE gobierno.solicitudes_cambio IS
'Registro de solicitudes de cambio en la base comercial. Propietario: Comité de cambios. Custodio: DBA. Evidencia de POL-06.';

-- Registro del escenario de la guía. Evitar duplicarlo si ya fue insertado.
INSERT INTO gobierno.solicitudes_cambio
    (folio, descripcion, solicitado_por, aprobado_por, ambiente,
     fecha_aprobacion, ventana_inicio, ventana_fin)
VALUES
    ('CAM-2026-014', 'Agregar columna canal_alta a clientes',
     'Gerencia Comercial', 'Comité de cambios', 'produccion',
     now() - interval '1 day', now() - interval '5 minutes',
     now() + interval '1 hour')
ON CONFLICT (folio) DO NOTHING;

-- Ejecutar el cambio solo si la columna todavía no existe y la ventana está autorizada.
-- ALTER TABLE public.clientes ADD COLUMN canal_alta VARCHAR(20);

-- Verificar la ventana y el registro de aprobación.
SELECT folio, aprobado_por,
       ventana_inicio <= now() AND now() <= ventana_fin AS dentro_de_ventana
FROM gobierno.solicitudes_cambio
ORDER BY folio;

-- Consulta para extraer eventos de estructura y privilegios desde LAB-01.
SELECT num,
       substr(linea, 1, 23) AS momento,
       substring(linea FROM 'user=([^ ]*)') AS usuario,
       substring(linea FROM 'statement: (.*)$') AS sentencia
FROM dba.bitacora
WHERE linea ~ 'statement: (CREATE|ALTER|DROP|GRANT|REVOKE)'
ORDER BY num;
