# 02 — Incidente sin perfilado

## Comandos de referencia
```javascript
db.getProfilingStatus()
db.system.profile.countDocuments()
bitacora().filter(e => JSON.stringify(e).includes("GAMA780912XXX")).length
```

## Resultado de referencia
- Perfilador: `was: 0` (apagado).
- Documentos en `system.profile`: `0`.
- Coincidencias del nuevo RFC en los eventos consultados: `0`.
- La bitácora sí muestra conexión y autenticación de la aplicación, pero no la operación de actualización.

## Interpretación
La aplicación ejecutó una actualización del RFC del cliente con `_id: 3`, y la respuesta indicó `matchedCount: 1` y `modifiedCount: 1`. Sin embargo, con el perfilador apagado no quedó un documento de operación en `system.profile`, y la bitácora consultada no conserva el detalle CRUD. Por ello no se puede demostrar con esas fuentes quién ejecutó específicamente el cambio ni recuperar el valor anterior.

`mongosh` puede abrir varias conexiones durante el inicio y la ejecución. La conexión relevante es la que contiene el evento `Successfully authenticated`; en el ejemplo aparecen contextos distintos, como `conn8` y `conn9`.

## Preguntas
1. **¿Se puede demostrar qué cambió y quién se conectó?** La respuesta de actualización demuestra que una operación modificó un documento, pero no deja evidencia suficiente del cambio en las fuentes consultadas. La bitácora permite identificar una autenticación de la aplicación, no atribuirle de manera concluyente la operación concreta.
2. **¿Por qué hay varias conexiones?** El cliente puede establecer conexiones para distintas fases o tareas de comunicación. La conexión que se autentica es la que registra `Successfully authenticated`; no debe asumirse que todos los contextos pertenecen a una sola conexión.
