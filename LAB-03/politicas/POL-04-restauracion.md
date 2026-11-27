# POL-04 — Restauración de información

**Objetivo:** evitar restauraciones no autorizadas, inconsistentes o que sobrescriban evidencia relevante.

**Alcance:** PostgreSQL 16, MongoDB 7 y sus ambientes de desarrollo, pruebas y producción.

**Regla:** toda restauración en producción requiere solicitud, justificación, alcance, punto de recuperación y aprobación del propietario del servicio y de Seguridad. El DBA ejecuta la restauración en una ventana autorizada y un responsable distinto verifica integridad y disponibilidad antes de liberar el servicio.

**Responsable:** propietario del servicio autoriza; DBA ejecuta; Seguridad o Auditoría verifica la evidencia y la separación de funciones.

**Excepciones:** contingencia crítica; la autorización puede ser posterior solo si queda registrada y ratificada dentro del siguiente día hábil.

**Evidencia:** registro de solicitudes de cambio, bitácora PostgreSQL, bitácora de MongoDB y acta de prueba de restauración. Esta entrega no contiene una restauración ejecutada ni un acta de prueba.

**Revisión:** semestral y después de cada restauración real.

**Nota:** El procedimiento técnico se definirá en la Unidad V.
