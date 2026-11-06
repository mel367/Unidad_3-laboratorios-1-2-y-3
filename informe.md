# Informe — LAB-01: Bitácoras y auditoría del dato en PostgreSQL

## 1. Despliegue y situación inicial

Se toma como escenario de referencia PostgreSQL 16, base `comercial`, en una instalación local de Windows 11. Esta plataforma es un supuesto de trabajo, no una instalación verificada.

En la configuración inicial ilustrativa, `logging_collector = off`, `log_connections = off` y `log_statement = none`. Con estos valores no se conserva la evidencia necesaria para identificar retrospectivamente una conexión o una sentencia UPDATE que no fue registrada.

## 2. Configuración aplicada

La simulación considera `logging_collector = on`, aplicado mediante reinicio, y los parámetros `log_connections`, `log_disconnections`, `log_line_prefix` y `log_statement`, aplicados mediante recarga.

| Parámetro | Valor ilustrativo | Aplicación |
|---|---|---|
| logging_collector | on | Reinicio |
| log_connections | on | Recarga |
| log_disconnections | on | Recarga |
| log_line_prefix | incluye usuario, base, PID, aplicación y cliente | Recarga |
| log_statement | ddl y posteriormente mod | Recarga |

## 3. Eventos observados en el escenario simulado

La bitácora de ejemplo contiene:
- Conexión autorizada de `app_ventas`.
- Fallo de autenticación de `soporte_ana`.
- Cambio de privilegios mediante `GRANT`.
- Creación y eliminación de una tabla de prueba.
- Error por falta de permisos.
- Cambio de configuración.
- UPDATE de datos.

La interpretación depende del contexto del prefijo: usuario, base, PID, aplicación y cliente. Estos eventos no son resultados de una ejecución real.

## 4. Auditoría del dato

El diseño crea `auditoria.cambios_clientes` para conservar fecha, usuario de sesión, usuario efectivo, aplicación, IP, operación, identificador y valores anteriores/nuevos en JSONB.

`SECURITY DEFINER` permite que la función se ejecute con los privilegios de su propietario. `session_user` conserva el rol con el que se autenticó la sesión; `current_user` representa los privilegios vigentes dentro de la función.

En el ejemplo, el RFC del cliente 3 cambia de `GAMA780912XXX` a `GAMA780912GHI`, asociado a `app_ventas`. Esos valores son ficticios y solo ilustran el resultado esperado.

## 5. Limitaciones

- El trigger descrito registra INSERT, UPDATE y DELETE, pero no SELECT.
- Un UPDATE masivo produce una fila de auditoría por cada registro afectado.
- El propietario o superusuario puede desactivar el trigger.
- La bitácora puede registrar sentencias con información sensible.
- `application_name` es declarado por el cliente y no constituye identidad fuerte.
- Un administrador con control total puede alterar mecanismos locales; por eso conviene enviar logs a infraestructura externa con custodia independiente.

## 6. Riesgos de la bitácora

La bitácora puede contener datos personales, secretos o direcciones internas. Antes de compartirla se debe revisar y redactar esa información. El acceso debe limitarse y la retención debe estar definida.

## 7. Cronología y conclusión

La cronología simulada muestra primero un cambio sin auditoría, que no puede atribuirse con certeza, y después un UPDATE con trigger activo que conserva usuario de sesión y valores anteriores/nuevos.

**Conclusión:** en el escenario de ejemplo, la combinación de bitácora del servidor y auditoría por fila permite responder más preguntas que cualquiera de los mecanismos por separado. Sin embargo, estos resultados son ilustrativos y no demuestran una ejecución real.

## 8. Preguntas de reflexión

1. **¿Por qué la auditoría no puede configurarse después de un incidente?** Porque solo registra eventos desde que está activa; no reconstruye de forma confiable operaciones pasadas que nunca generaron evidencia.
2. **¿Por qué conviene que la bitácora la administre el servidor?** Porque centraliza el registro en PostgreSQL y no depende del mecanismo de despliegue para escribirlo; aun así, deben protegerse los archivos.
3. **¿Por qué el prefijo importa tanto como `log_statement`?** `log_statement` define qué sentencias se registran; el prefijo aporta contexto para atribuirlas a una sesión, usuario, aplicación y cliente.
4. **¿Qué diferencia hay entre registrar sentencia y registrar cambio?** La sentencia conserva el SQL ejecutado; el trigger puede conservar los valores anteriores y nuevos por cada fila afectada.
5. **¿Qué ofrece `pg_stat_activity` y qué ofrece la bitácora?** La primera muestra el estado actual de sesiones; la segunda conserva eventos históricos.
6. **Si el administrador puede cambiar `log_statement` y desactivar el trigger, quién lo audita?** La evidencia debe enviarse a un sistema externo bajo custodia independiente, con separación de funciones y revisión administrativa.
