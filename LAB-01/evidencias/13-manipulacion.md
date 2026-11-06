# Evidencia 13 — Manipulación del mecanismo de auditoría

Evento de ejemplo:
```text
LOG: statement: ALTER TABLE clientes DISABLE TRIGGER trg_auditoria_clientes
```

**Respuestas:**
- La bitácora del servidor puede registrar que se desactivó el trigger, si la configuración registra esa sentencia.
- Un control administrativo útil es separar al DBA que opera de la persona/área que custodia y revisa la evidencia.
- Esto aplica el principio de separación de funciones: quien modifica el sistema no debe tener control exclusivo sobre la evidencia de sus propias acciones.
