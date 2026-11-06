# 01 — Edición y limitación

## Comandos de referencia
```javascript
db.version()
db.adminCommand({ buildInfo: 1 }).modules
db.serverCmdLineOpts().parsed
```

## Resultado de referencia del instructivo
- Versión: `7.0.43`.
- `modules`: arreglo vacío (`[]`).
- La configuración observada muestra `security.authorization: enabled`.

## Interpretación
La edición corresponde a MongoDB Community. El arreglo `modules` vacío es la evidencia presentada por la guía; en Enterprise se esperaría el módulo `enterprise`. La autorización está habilitada, pero eso no significa que exista auditoría nativa.

La ubicación de la bitácora depende de `systemLog.destination` y `systemLog.path`. Si no se configura un archivo, los mensajes pueden ir a la salida estándar. La salida de `db.serverCmdLineOpts().parsed` permite revisar la configuración efectiva.

## Preguntas
1. **¿Qué edición se usa y qué lo demuestra?** MongoDB 7.0.43 Community; la guía muestra `modules: []`.
2. **¿Dónde escribe la bitácora?** Depende de la configuración efectiva de `systemLog`. El resultado resumido de la guía no proporciona una ruta concreta, por lo que no se debe inventar una.
3. **¿Qué categorías cubre la auditoría nativa?** Cambios de esquema; eventos de replica sets y clústeres fragmentados; autenticación y autorización; operaciones CRUD cuando se habilita `auditAuthorizationSuccess: true`.
4. **¿Qué evaluar antes de licenciar Enterprise o migrar a Atlas?** Costo de licencia/servicio, volumen de eventos, requisitos de conservación, impacto operativo, controles de acceso, cumplimiento y si la necesidad real justifica cambiar de edición o plataforma.
