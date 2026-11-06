# Evidencia 02 — Colector y lectura de bitácora


Se supone que `logging_collector` se cambia a `on` y que PostgreSQL se reinicia. Después se consulta `pg_current_logfile()` y se habilita la lectura mediante la vista indicada en el laboratorio.

Resultado ilustrativo:
```text
 pg_current_logfile
-------------------------
 log/postgresql-2026-11-05.log
(1 row)
```
