# 03 — Perfilador

## Configuración y operaciones
```javascript
db.setProfilingLevel(2)
db.getProfilingStatus()
```
La aplicación realiza una consulta, una actualización del RFC de `_id: 3` y una eliminación del documento `_id: 2`.

## Interpretación de resultados de referencia

| Operación | Usuario | Cliente | Aplicación | Momento UTC | Acción | Documentos afectados |
|---|---|---|---|---|---|---:|
| `query` | `app_ventas@comercial` | `127.0.0.1` | `app-ventas-web` | 2026-10-25 22:52:45.906 | Consulta clientes de Culiacán | 3 devueltos |
| `update` | `app_ventas@comercial` | `127.0.0.1` | `app-ventas-web` | 2026-10-25 22:52:45.909 | Actualiza RFC de `_id: 3` a `GAMA780912XYZ` | 1 modificado |
| `remove` | `app_ventas@comercial` | `127.0.0.1` | `app-ventas-web` | 2026-10-25 22:52:45.915 | Elimina `_id: 2` | 1 eliminado |

## Preguntas
1. **¿Se conoce el RFC anterior?** No. El perfilador registra la operación y el valor enviado en la actualización, pero no conserva automáticamente una copia del valor previo.
2. **¿Se conocen los datos del documento eliminado?** No necesariamente. El registro muestra el filtro y el resultado de la eliminación, pero no es una copia completa del documento eliminado.
3. **Ventaja y riesgo del nivel 2 frente a registrar solo modificaciones:** permite observar también consultas y otras operaciones; como riesgo, genera más volumen, consume espacio y puede registrar filtros o información sensible, además de afectar el rendimiento.
4. **¿Por qué `user` incluye `@comercial`?** Porque identifica al usuario y la base de datos de autenticación en la que está definido.
