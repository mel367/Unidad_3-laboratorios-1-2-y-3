# Evidencia 10 — Diseño de tabla de auditoría

La tabla `auditoria.cambios_clientes` conserva, según el diseño del laboratorio: fecha, usuario de sesión, usuario efectivo, aplicación, IP, operación, identificador del cliente y valores anteriores/nuevos en JSONB.

**Respuestas:**
- `TIMESTAMPTZ` conserva un instante con referencia de zona horaria, útil para correlacionar eventos.
- JSONB permite conservar una representación flexible del registro completo antes y después.
- Como los valores pueden incluir RFC y otros datos personales, la tabla de auditoría también requiere clasificación, permisos limitados y retención controlada.
