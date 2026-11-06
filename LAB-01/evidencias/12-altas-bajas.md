# Evidencia 12 — INSERT y DELETE

Ejemplos de filas que produciría el trigger:
| Operación | Valores anteriores | Valores nuevos |
|---|---|---|
| INSERT | NULL | Registro insertado en JSONB |
| DELETE | Registro eliminado en JSONB | NULL |

**Interpretación:** el trigger `AFTER ... FOR EACH ROW` genera una fila por cada registro afectado. En INSERT se conserva `NEW`; en DELETE se conserva `OLD`.
