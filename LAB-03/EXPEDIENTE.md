# Expediente de auditoría interna — Base comercial

## 1. Alcance
Se revisa la base comercial de Comercializadora Norte S.A. de C.V. en PostgreSQL 16 (`comercial`) y MongoDB 7 (`comercial`). El periodo de referencia del escenario es octubre de 2026. Responsable de integración: DBA de la base comercial. Los nombres de host y el periodo definitivo deben corresponder al entorno auditado.

## 2. Configuración de auditoría (A3)
PostgreSQL utiliza colector de bitácoras, registro de conexiones/desconexiones y `log_statement = mod`. La configuración de referencia está en `evidencias/E1-configuracion-registro.txt`. El disparador de auditoría de clientes se documenta en `evidencias/E3-disparadores.txt`, y la muestra de eventos en `evidencias/E4-muestra-auditoria.txt`.
MongoDB Community aporta la bitácora del servidor y el perfilador `system.profile`; ver `evidencias/E6-mongodb/`. El perfilador no representa una auditoría completa.

## 3. Bitácora interpretada (A3, A5)
1. **Cambio de privilegios:** evento 35, usuario `postgres`, 25-10-2026 22:50:09, aplicación `psql`, ejecutó `GRANT UPDATE ON clientes TO app_ventas`. Es un cambio de autorización. Debe existir solicitud aprobada y coincidir con POL-01/POL-06. Fuente: `evidencias/E5-bitacora-postgresql.log`.
2. **Desactivación de auditoría:** evento 163, usuario `app_ventas`, 25-10-2026 22:50:53, aplicación `ventas`, intentó ejecutar `ALTER TABLE clientes DISABLE TRIGGER trg_auditoria_clientes`. La cuenta de aplicación no debería tener privilegios DDL; se clasifica como hallazgo alto. Fuente: `evidencias/06-conciliacion.md` y E5.
3. **Desactivación administrativa:** evento 169, usuario `postgres`, ejecutó la misma desactivación; el evento 171 registra la reactivación. La reactivación no recupera eventos que pudieron quedar sin auditar. Fuente: `evidencias/E5-bitacora-postgresql.log`.
4. **Incidente del RFC de María García:** la evidencia disponible en este expediente no incluye el identificador ni la secuencia íntegra de eventos de ese incidente. Debe incorporarse desde la cronología y evidencia de auditoría del LAB-01 antes de cerrar el expediente; no se atribuye un valor de RFC sin la fuente original.

## 4. Elementos de gobierno (A1, A2)
La matriz de propietarios, custodios y usuarios está en `evidencias/02-responsables.md`; el catálogo de cinco conjuntos de datos está en `evidencias/04-catalogo.md`; el diccionario y sus clasificaciones están en `evidencias/03-diccionario.md` y `evidencias/diccionario-clientes.csv`.

## 5. Conservación (A3)
Se proponen periodos diferenciados para accesos, cambios de privilegios, modificaciones, auditoría de clientes, bitácora MongoDB, perfilado e instantáneas. La matriz y las acciones al vencer están en `evidencias/05-conservacion.md`. Los plazos sujetos a obligaciones normativas deben confirmarse con Jurídico.

## 6. Políticas (A4)
- POL-01 Acceso: `politicas/POL-01-acceso.md`.
- POL-02 Respaldo: `politicas/POL-02-respaldo.md`.
- POL-03 Retención: `politicas/POL-03-retencion.md`.
- POL-04 Restauración: `politicas/POL-04-restauracion.md`.
- POL-05 Datos sensibles: `politicas/POL-05-datos-sensibles.md`.
- POL-06 Cambios en producción: `politicas/POL-06-cambios-produccion.md`.

## 7. Conciliación de cambios (A5)
El cambio `canal_alta` se vincula con CAM-2026-014 y aparece en el fragmento de bitácora. La desactivación del disparador y el GRANT requieren folio y aprobación; al no encontrarse en el registro mínimo del escenario, se mantienen como pendientes/hallazgos. Ver `evidencias/06-conciliacion.md` y `sql/04-registro-cambios.sql`.

## 8. Hallazgos

| ID | Hallazgo | Fuente | Severidad | Impacto | Recomendación | Decisión requerida de |
|---|---|---|---|---|---|---|
| H-01 | Correo duplicado, RFC/correo inválidos y datos incompletos | 01-calidad.md | Media | Contacto o facturación incorrectos | Validar con cliente y aprobar corrección | Gerencia Comercial / Facturación |
| H-02 | Cuenta de aplicación intenta deshabilitar trigger | 06-conciliacion.md | Alta | Posible pérdida de trazabilidad | Retirar DDL a la cuenta y revisar sesiones | Seguridad / DBA |
| H-03 | Desactivación del trigger por cuenta administrativa sin folio identificado | E5 y conciliación | Alta | Intervalo sin auditoría de cambios | Investigar y exigir aprobación de emergencia | Comité de cambios / Auditoría |
| H-04 | GRANT sin solicitud vinculada en el registro disponible | E5 / E2 | Media | Privilegios fuera de control documental | Conciliar con matriz de roles y formalizar folio | Gerencia Comercial / Seguridad |
| H-05 | Huecos históricos cuando `log_statement` estuvo en `none` | E5 / LAB-01 | Alta | No es posible reconstruir todas las sentencias | Declarar alcance y reforzar monitoreo externo | Seguridad / Auditoría |
| H-06 | MongoDB Community carece de auditoría nativa empresarial | E6-mongodb/09-comparacion.md | Media | Cobertura parcial de operaciones | Aceptar formalmente o evaluar solución complementaria | Seguridad / Dirección |

## 9. Limitaciones conocidas y riesgos aceptados (A6)
- **MongoDB Community:** se verificaron bitácora del servidor y perfilado; la auditoría nativa empresarial no se practicó. Riesgo residual: operaciones no cubiertas por esos mecanismos. Aceptación: Seguridad y Dirección.
- **Lecturas PostgreSQL:** `log_statement = mod` no registra SELECT rutinarios. Sin `pgaudit` u otro mecanismo, la trazabilidad de lecturas es parcial. Aceptación: Seguridad y Auditoría.
- **Administrador:** una cuenta con privilegios suficientes puede desactivar triggers o modificar configuración. La separación de funciones y el almacenamiento externo reducen, pero no eliminan, el riesgo. Aceptación: Dirección y Seguridad.
- **Huecos de configuración:** si el nivel de registro estuvo en `none`, no existe evidencia retroactiva de las sentencias omitidas. Aceptación: Auditoría Interna.
- **Datos personales en auditoría:** conservar evidencia puede entrar en tensión con la eliminación de datos. Jurídico debe definir la base y el plazo aplicables antes de eliminar o anonimizar.

## 10. Índice de evidencias
- `evidencias/01-calidad.md`
- `evidencias/02-responsables.md`
- `evidencias/03-diccionario.md`
- `evidencias/04-catalogo.md`
- `evidencias/05-conservacion.md`
- `evidencias/06-conciliacion.md`
- `evidencias/diccionario-clientes.csv`
- `evidencias/E1-configuracion-registro.txt`
- `evidencias/E2-privilegios.txt`
- `evidencias/E3-disparadores.txt`
- `evidencias/E4-muestra-auditoria.txt`
- `evidencias/E5-bitacora-postgresql.log` y `E5-bitacora-postgresql.sha256`
- `evidencias/E6-mongodb/` (perfil, bitácora, comparación y hashes)

Los archivos E1–E6 contienen salidas de referencia derivadas del escenario y deben sustituirse por exportaciones verificadas del entorno antes de emitir el expediente como evidencia final.
