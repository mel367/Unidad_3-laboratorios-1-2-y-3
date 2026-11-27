# 05 — Criterio de conservación de bitácoras

| Registro | Ubicación actual | Riesgo de pérdida | Sensibilidad | Periodo propuesto | Justificación | Dónde se conserva | Quién puede leerlo | Acción al vencer |
|---|---|---|---|---|---|---|---|---|
| Accesos PostgreSQL | Archivo del colector | Rotación, reinstalación o pérdida del servidor | Media/alta | 12 meses | Investigar accesos y patrones anómalos | Repositorio central de logs con acceso restringido | Seguridad y Auditoría | Eliminar de forma controlada tras verificar que no exista retención legal o investigación |
| Cambios de privilegios y estructura | Archivo del colector | Rotación y alteración por administrador | Alta | 24 meses | Cambios pueden conceder acceso persistente o debilitar controles | Repositorio central inmutable o con control de integridad | Seguridad y Auditoría | Baja documentada y destrucción segura; preservar si hay investigación |
| Modificaciones de datos (`log_statement=mod`) | Archivo del colector | Rotación; volumen elevado | Alta | 24 meses para eventos críticos; consultas rutinarias según política de volumen | Permite reconstruir cambios relevantes; revisar exposición de secretos | Repositorio central cifrado y con hash | Auditoría y Seguridad | Depuración por lote autorizado; conservar evidencia bajo retención preventiva |
| `auditoria.cambios_clientes` | Tabla en comercial | Borrado/alteración desde la propia base | Alta; datos personales | 24 meses | Evidencia de cambios de clientes | Base protegida y exportaciones periódicas firmadas/hash | Auditoría; DBA con acceso operativo limitado | Aplicar anonimización o eliminación autorizada cuando proceda; preservar evento mínimo si Jurídico lo permite |
| Bitácora `mongod` | Archivo `systemLog.path` o salida estándar | Rotación, pérdida de contenedor/host; `getLog` es temporal | Media/alta | 12 meses | Accesos, errores y operaciones administrativas | Repositorio central de logs | Seguridad y Auditoría | Eliminación controlada con registro |
| `system.profile` | Colección limitada | Se sobrescribe al alcanzar límite | Alta si registra consultas y filtros | 30 días | Perfilado operativo, no archivo probatorio de largo plazo | Exportación selectiva a repositorio seguro si hay incidente | DBA; Auditoría bajo solicitud | Depuración automática y documentada |
| Instantáneas de privilegios MongoDB | `auditoria.instantaneas_privilegios` | Alteración/borrado o falta de nuevas capturas | Alta | 12 meses | Comparar cambios de roles y permisos | Colección restringida y exportación periódica con hash | Seguridad y Auditoría | Retirar al vencer y conservar constancia |

## Respuestas
- Los cambios de privilegios merecen más tiempo porque pueden abrir accesos, crear persistencia o debilitar controles con efectos que se descubren meses después.
- Las exportaciones se protegen con SHA-256, almacenamiento separado, permisos mínimos y registro de quién generó/recibió cada copia. El hash detecta cambios, pero por sí solo no impide que alguien reemplace archivo y hash.
- Conservar bitácoras preserva evidencia de eventos; respaldar una base preserva la posibilidad de recuperar datos y objetos operativos. Son objetivos distintos y complementarios.

**Nota normativa:** cualquier plazo legal específico queda como “Plazo a confirmar con el área jurídica”, revisando obligaciones fiscales, mercantiles, privacidad, contratos y requerimientos de autoridad aplicables.
