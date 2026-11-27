# 03 — Diccionario operativo de `public.clientes`

Los comentarios del motor documentan el significado junto con la estructura. La consulta de `information_schema.columns` aporta tipo, longitud, nulabilidad y valor predeterminado; `col_description` aporta el significado operativo.

| Columna | Clasificación | Finalidad | Control aplicado | ¿Cambios auditados? | Regla de calidad |
|---|---|---|---|---|---|
| id | Interno | Identificador de cliente | PK / generación automática | Sí, como referencia del evento | No nulo y único |
| nombre | Dato personal | Identificación y atención | Acceso restringido | Sí, si el disparador cubre la columna | No vacío |
| correo | Dato personal | Notificaciones | Vista restringida / validación | Sí | Formato y unicidad normalizada |
| telefono | Dato personal | Contacto | Acceso restringido | Sí | Longitud y caracteres válidos |
| rfc | Dato personal | Facturación | Vista enmascarada para soporte | Sí, LAB-01 Parte B | Formato RFC y validación documental |
| edad | Dato personal | Analítica agregada | Minimización | Sí | Rango operativo 18–120 |
| ciudad | Dato personal indirecto | Segmentación geográfica | Acceso por función | Sí | Catálogo de localidades |
| codigo_postal | Dato personal indirecto | Cobertura / facturación | Acceso restringido | Sí | Cinco dígitos para el escenario |
| fecha_alta | Dato operativo | Antigüedad del cliente | Generación controlada | Sí | Fecha válida; no futura |
| segmento | Dato comercial interno | Segmentación | Aprobación comercial | Sí | Valor perteneciente al catálogo autorizado |
| canal_alta | Dato operativo/comercial | Identificar canal de registro | Cambio CAM-2026-014 | Sí, si el trigger registra la columna | Valor de catálogo |

## Respuestas
- `COMMENT` mantiene el significado junto al objeto y puede consultarse desde herramientas que leen metadatos; reduce la divergencia entre estructura y documentación externa.
- Los `COMMENT` son sentencias DDL. Con `log_statement = 'mod'` no se garantiza que todos los `COMMENT` queden registrados, porque `mod` cubre DDL y operaciones de modificación según el comportamiento configurado; se debe verificar la bitácora concreta. Para evidencia histórica se requiere exportación del periodo.
- Fuera del motor deben mantenerse propietario organizacional, finalidad autorizada, clasificación, base legal, reglas de conservación, contactos responsables y criterios de negocio que no puedan expresarse como metadatos SQL.

## Evidencia
`../sql/02-comentarios-diccionario.sql` y `diccionario-clientes.csv`.
