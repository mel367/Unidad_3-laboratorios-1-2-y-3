# Evidencia 11 — Incidente auditado

Evento de ejemplo:
```text
UPDATE clientes SET rfc = 'GAMA780912GHI' WHERE id = 3
```
Fila ficticia de auditoría:
| id_evento | usuario_sesion | operacion | id_cliente | rfc anterior | rfc nuevo |
|---:|---|---|---:|---|---|
| 7 | app_ventas | UPDATE | 3 | GAMA780912XXX | GAMA780912GHI |

**Interpretación:** el trigger permite asociar el cambio con la sesión y conservar los valores anterior y nuevo. Los identificadores y valores de esta tabla son demostrativos, no extraídos de una ejecución real.
