# 04 — Filtro del perfilador

## Comandos de referencia
```javascript
db.setProfilingLevel(0)
db.system.profile.drop()
db.setProfilingLevel(1, {
  filter: { op: { $in: ["insert", "update", "remove"] } }
})
db.getProfilingStatus()
```

## Resultado de referencia
El estado muestra nivel 1 y un filtro que incluye `insert`, `remove` y `update`. La consulta posterior devuelve una actualización de `comercial.clientes`; la operación `find` no aparece.

## Preguntas
1. **¿Qué se perdió y qué se ganó?** Se perdió el registro de lecturas y de operaciones que no coinciden con el filtro. Se redujo el volumen almacenado y se concentró el registro en modificaciones.
2. **¿Qué filtro usar para limitarlo a `clientes`?** Se puede agregar una condición sobre el espacio de nombres, por ejemplo:
```javascript
db.setProfilingLevel(1, {
  filter: {
    op: { $in: ["insert", "update", "remove"] },
    ns: "comercial.clientes"
  }
})
```
El filtro debe verificarse en la versión y configuración concretas del servidor antes de adoptarlo como control permanente.
