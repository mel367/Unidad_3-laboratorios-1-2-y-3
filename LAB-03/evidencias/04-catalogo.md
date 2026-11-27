# 04 — Catálogo mínimo de datos

| ID | Conjunto de datos | Motor | Ubicación | Propietario | Custodio | Clasificación | Datos personales | Finalidad | Conservación | Diccionario |
|---|---|---|---|---|---|---|---|---|---|---|
| CAT-01 | Clientes | PostgreSQL 16 | servidor-pg / comercial / public.clientes | Gerencia Comercial | DBA | Confidencial | Sí | Operación comercial y facturación | Según POL-03; plazo legal a confirmar | diccionario-clientes.csv |
| CAT-02 | Auditoría de clientes | PostgreSQL 16 | servidor-pg / comercial / auditoria.cambios_clientes | Auditoría Interna | DBA | Restringido | Sí, puede identificar clientes y usuarios | Trazabilidad de modificaciones | 24 meses, sujeto a retención legal | Metadatos de tabla y eventos |
| CAT-03 | Registro de cambios | PostgreSQL 16 | servidor-pg / comercial / gobierno.solicitudes_cambio | Comité de cambios | DBA | Interno restringido | Puede contener nombres de solicitantes | Autorizar y conciliar cambios | 24 meses | Columnas de solicitudes_cambio |
| CAT-04 | Clientes (tienda) | MongoDB 7 | servidor-mongo / comercial / clientes | Gerencia Comercial | Administrador MongoDB | Confidencial | Sí | Operación de tienda | Alinear con CAT-01 y POL-03 | Esquema/documentación de LAB-02 |
| CAT-05 | Perfilado | MongoDB 7 | servidor-mongo / comercial / system.profile | Seguridad de la Información | Administrador MongoDB | Restringido | Puede contener filtros, identificadores y consultas | Diagnóstico y trazabilidad técnica | 30 días por rotación limitada | Estructura de system.profile |

## Respuestas
- CAT-02 y CAT-05 pueden contener datos personales indirectos: identificadores, valores consultados, filtros, usuarios, direcciones y marcas de tiempo. La finalidad de auditoría no elimina la sensibilidad.
- Si CAT-01 y CAT-04 tienen propietarios distintos y difiere el RFC, debe detenerse la sincronización automática y escalarse a los propietarios y Facturación para determinar el dato maestro. No se debe elegir un valor por criterio del DBA.
- Ubicación, custodio operativo, clasificación, volumen, finalidad y periodo de conservación pueden cambiar. El custodio actualiza los metadatos técnicos; el propietario valida finalidad, clasificación y reglas; Auditoría revisa cambios relevantes.

## Inventario técnico
Consulta: `../sql/03-inventario-tablas.sql`. La vista `dba.bitacora` también se registra en el catálogo aunque no aparezca en la consulta de tablas físicas.
