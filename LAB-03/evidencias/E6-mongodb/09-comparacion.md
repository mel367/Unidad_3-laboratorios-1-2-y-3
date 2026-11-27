# Comparación PostgreSQL / MongoDB

| Aspecto | PostgreSQL 16 | MongoDB 7 Community |
|---|---|---|
| Registro de sentencias | `log_statement = mod` registra DDL y modificaciones, no lecturas rutinarias | La bitácora de mongod registra eventos de servidor; no equivale a auditoría completa por documento |
| Auditoría de cambios | Disparador en `clientes` escribe en `auditoria.cambios_clientes` | El perfilador registra operaciones seleccionadas, pero no es un historial íntegro y permanente |
| Lecturas | No quedan registradas por `mod`; requiere extensión o mecanismo adicional para auditoría de consultas | `system.profile` puede mostrar consultas perfiladas, sujeto a configuración y límite |
| Privilegios | Roles y GRANT/REVOKE aparecen en bitácora si el registro estaba habilitado | Instantáneas de privilegios permiten comparar estados; no sustituyen auditoría nativa |
| Limitaciones | Administrador puede alterar controles; huecos si `log_statement=none` | Community no incluye auditoría nativa empresarial; perfilado es limitado y se sobrescribe |

Conclusión: ambos motores ofrecen trazabilidad útil, pero ninguno de estos mecanismos por sí solo demuestra que todas las operaciones fueron registradas.
