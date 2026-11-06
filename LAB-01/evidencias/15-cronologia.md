# Evidencia 15 — Cronología del incidente

| Hora de ejemplo | Evento | Interpretación |
|---|---|---|
| 18:02 | Conexión de administrador | Inicio de preparación |
| 18:04 | Conexión de `app_ventas` | Sesión de la aplicación |
| 18:05 | UPDATE inicial sin auditoría | El cambio no puede atribuirse con la configuración inicial |
| 18:09 | Autenticación fallida | Intento fallido de `soporte_ana` |
| 18:12 | GRANT | Cambio de privilegios |
| 18:25 | UPDATE con trigger activo | Se registra el cambio en la auditoría |
| 18:27 | Trigger desactivado | Se demuestra un límite administrativo del mecanismo |

**Conclusión:** la correlación entre bitácora del servidor y tabla de auditoría aporta contexto sobre quién ejecutó una operación y qué valores cambiaron. Esta cronología es ilustrativa; debe reemplazarse por los tiempos reales si se ejecuta el laboratorio.
