# Evidencia 03 — Incidente sin bitácora

Acción de ejemplo:
```sql
UPDATE clientes SET rfc = 'GAMA780912XXX' WHERE id = 3;
```
Salida ilustrativa:
```text
UPDATE 1
```
Búsqueda posterior en la bitácora:
```text
 linea
-------
(0 rows)
```

**Respuestas:**
- ¿Puede demostrarse quién modificó el RFC? No, porque en el escenario inicial no se registró la conexión ni la sentencia.
- ¿Puede demostrarse que no fue `soporte_ana`? Tampoco. La ausencia de registro no demuestra quién no realizó la operación.
- ¿Los privilegios impidieron el cambio? No necesariamente: `app_ventas` tenía permiso de UPDATE.
- ¿Qué debía configurarse antes? El registro de conexiones/sentencias y un mecanismo de auditoría por fila que guardara valores anteriores y nuevos.
