# Evidencia 04 — Configuración de bitácora

Parámetros ilustrativos:
```sql
ALTER SYSTEM SET log_connections = on;
ALTER SYSTEM SET log_disconnections = on;
ALTER SYSTEM SET log_line_prefix = '%m [%p] user=%u db=%d app=%a client=%h ';
ALTER SYSTEM SET log_statement = 'ddl';
SELECT pg_reload_conf();
```

| Parámetro | Valor supuesto | Aplicación |
|---|---|---|
| log_connections | on | Recarga |
| log_disconnections | on | Recarga |
| log_line_prefix | formato con usuario, base, PID, app y cliente | Recarga |
| log_statement | ddl | Recarga |
| logging_collector | on | Reinicio |


