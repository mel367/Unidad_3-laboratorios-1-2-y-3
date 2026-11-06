-- LAB-01 | Actividad 6

REVOKE UPDATE ON clientes FROM soporte_ana;
GRANT UPDATE ON clientes TO app_ventas;
ALTER TABLE clientes ADD COLUMN IF NOT EXISTS segmento VARCHAR(20);
