# 09 — Comparación de escenarios

La tabla distingue los mecanismos documentados en la guía. En PostgreSQL se resume el enfoque del LAB-01; en MongoDB Community se consideran perfilador y bitácora; Enterprise/Atlas se marca como documentado, no practicado.

| Evento | PostgreSQL (bitácora + disparador) | MongoDB Community (perfilador + bitácora) | MongoDB Enterprise/Atlas |
|---|---|---|---|
| Acceso exitoso | Sí, observado en bitácora | Sí, observado en ACCESS | Documentado, no practicado |
| Acceso fallido | Sí, observado en bitácora | Sí, observado en ACCESS | Documentado, no practicado |
| Cambio de privilegios | Parcial: depende de eventos/configuración registrados | No: instantáneas solo detectan diferencias | Documentado, no practicado |
| Cambio de estructura | Parcial: depende de configuración y registro | Parcial: el perfilador puede registrar comandos, no equivale a auditoría | Documentado, no practicado |
| Modificación de datos | Sí, con disparador sobre los datos cubiertos | Sí, perfilador registra operaciones mientras está activo | Documentado, no practicado |
| Valor anterior del dato | Sí, si el disparador conserva OLD | No, el perfilador no guarda automáticamente el valor previo | Documentado, no practicado |
| Lectura de datos sensibles | Parcial, depende de configuración | Sí, puede registrar consultas con perfilado adecuado | Documentado, no practicado |
| Cambio de configuración del registro | Parcial, depende de los eventos registrados | Sí, la bitácora muestra el cambio del perfilador | Documentado, no practicado |

## Nota
La guía solicita marcar Sí (observado), Parcial (explica) o No. Para Enterprise/Atlas corresponde usar “Documentado, no practicado”. La columna de PostgreSQL debe revisarse contra los resultados reales del LAB-01, porque este paquete no sustituye esa evidencia.
