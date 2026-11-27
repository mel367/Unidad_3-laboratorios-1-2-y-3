# 02 — Matriz de propietarios, custodios y usuarios

| Conjunto de datos | Propietario | Custodio | Usuarios autorizados | Quién aprueba accesos | Quién aprueba correcciones |
|---|---|---|---|---|---|
| comercial.public.clientes (PostgreSQL) | Gerencia Comercial | DBA | Aplicación de ventas; soporte con vista enmascarada | Gerencia Comercial | Gerencia Comercial; Facturación valida RFC |
| auditoria.cambios_clientes (PostgreSQL) | Auditoría Interna | DBA bajo control de Seguridad | Auditoría y Seguridad; DBA para soporte técnico justificado | Responsable de Auditoría | No se corrigen eventos; cualquier rectificación se agrega como evento complementario autorizada por Auditoría |
| Bitácora de PostgreSQL | Seguridad de la Información | DBA | Seguridad y Auditoría; DBA con acceso operativo restringido | Seguridad de la Información | No aplica; se preserva original y se documenta aclaración |
| comercial.clientes (MongoDB) | Gerencia Comercial | Administrador MongoDB / DBA | Aplicación de tienda y soporte autorizado | Gerencia Comercial | Gerencia Comercial |
| comercial.system.profile (MongoDB) | Seguridad de la Información | Administrador MongoDB / DBA | DBA y Auditoría bajo necesidad | Seguridad de la Información | No aplica; se conserva como registro técnico |

## Respuestas
- El propietario de `auditoria.cambios_clientes` debe ser independiente del operador de `clientes` para reducir el conflicto de interés. Quien administra los datos no debe poder alterar sin supervisión la evidencia que permitiría revisar sus acciones.
- Las bitácoras y `dba.bitacora` deben tener lectura restringida. El LAB-01 mostró que las sentencias registradas pueden contener secretos, por lo que se deben redactar credenciales antes de compartir exportaciones y limitar su acceso.
- Si nadie tiene asignada la propiedad, las decisiones de corrección, acceso, conservación y eliminación quedan sin autoridad clara. El DBA podría terminar tomando decisiones de negocio que no le corresponden y los errores permanecerían sin responsable.
