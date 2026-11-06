# Evidencia 14 — Límites: lecturas y volumen

- Un trigger de INSERT/UPDATE/DELETE no registra por sí mismo las lecturas SELECT.
- Un UPDATE masivo genera una fila de auditoría por cada registro afectado; el volumen puede crecer rápidamente.
- `log_statement = 'all'` puede registrar consultas con datos sensibles y aumentar el volumen de la bitácora.

**Respuestas:**
1. Si la tabla tuviera un millón de registros y el UPDATE afectara todos, el trigger podría insertar hasta un millón de filas de auditoría.
2. La depuración debe autorizarla un responsable independiente conforme a una política de retención.
3. `log_statement = 'all'` puede convertir el log en un repositorio adicional de información sensible, por lo que debe protegerse y depurarse.
