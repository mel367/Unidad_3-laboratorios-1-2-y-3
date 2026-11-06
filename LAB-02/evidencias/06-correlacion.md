# 06 — Correlación de cambio de configuración

## Eventos de referencia
La bitácora registra `Profiler settings changed` en el contexto `conn31`. El evento de autenticación del mismo contexto muestra:
- Usuario: `admin`.
- Base de autenticación: `admin`.
- Cliente: `127.0.0.1`.

## Interpretación
La correlación permite atribuir el cambio de configuración del perfilador al usuario `admin`, porque el evento de modificación y el evento de autenticación comparten el mismo contexto de conexión (`ctx: conn31`).

## Preguntas
1. **¿Qué usuario cambió la configuración?** `admin`. Lo demuestran el evento `Profiler settings changed` y el evento `Successfully authenticated` asociado al mismo `ctx`.
2. **¿Qué condición hace válida la correlación?** Ambos eventos deben pertenecer al mismo periodo de ejecución del servidor. No se deben correlacionar identificadores `ctx` a través de reinicios, porque los números de conexión pueden reiniciarse y reutilizarse.
3. **¿Por qué registrar cambios del propio mecanismo de registro?** Porque permite detectar cuándo se alteró la cobertura de observación. Sin ese dato, una reducción de registros podría confundirse con ausencia de actividad.
