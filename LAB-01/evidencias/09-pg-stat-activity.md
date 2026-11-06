# Evidencia 09 — pg_stat_activity

Consulta ilustrativa:
```sql
SELECT pid, usename, application_name, state
FROM pg_stat_activity
WHERE datname = 'comercial';
```

Salida ficticia:
```text
 pid  | usename | application_name | state
------+---------+------------------+-------
 4201 | app_ventas | app-ventas-web | active
(1 row)
```

**Interpretación:** `pg_stat_activity` describe sesiones y consultas en su estado actual. No sustituye la bitácora histórica: una vez terminada la sesión, su información deja de representar ese evento pasado.
