# POL-06 — Gestión de cambios en producción

**Objetivo:** impedir modificaciones no autorizadas y conservar una relación verificable entre aprobación, ejecución y resultado.

**Alcance:** cambios de esquema, datos de configuración, roles, privilegios, disparadores, parámetros de auditoría y despliegues de aplicaciones en el ambiente de producción. Se entiende por producción el ambiente que presta el servicio real a los usuarios y opera con datos reales, conforme a la definición de la Unidad I.

**Regla:** antes del cambio debe existir folio, descripción, solicitante, aprobador, evaluación de impacto y ventana autorizada. Durante la ejecución, el DBA utilizará una cuenta individual y no deshabilitará controles de auditoría salvo excepción aprobada. Después del cambio, se verificará el resultado y se conciliará la bitácora con el folio.

**Responsable:** Comité de cambios aprueba; propietario del dato valida impacto; DBA ejecuta; Auditoría o un revisor independiente realiza la conciliación.

**Excepciones:** emergencia documentada y ratificada por el Comité de cambios dentro del siguiente día hábil.

**Evidencia:** `gobierno.solicitudes_cambio`, E5-bitacora-postgresql.log, E3-disparadores.txt y `evidencias/06-conciliacion.md`. Los cambios sin folio se registran como hallazgos, aunque correspondan a preparación de laboratorio.

**Revisión:** trimestral y después de cambios críticos.
