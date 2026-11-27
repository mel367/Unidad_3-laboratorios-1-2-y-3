# POL-01 — Control de acceso

**Objetivo:** reducir accesos excesivos, cuentas sin justificación y exposición de datos personales.

**Alcance:** PostgreSQL 16, MongoDB 7 y aplicaciones que consulten la base comercial, en desarrollo, pruebas y producción.

**Regla:** toda alta, modificación o revocación de acceso debe originarse en una solicitud identificable y contar con aprobación del propietario del dato o del responsable delegado. El DBA ejecuta el cambio y conserva la evidencia. Los privilegios se revisan mensualmente y al cambiar una función laboral.

**Responsable:** Gerencia Comercial aprueba accesos a datos comerciales; responsable de Auditoría aprueba accesos a registros de auditoría; DBA administra técnicamente las cuentas.

**Excepciones:** acceso urgente por incidente, autorizado por el responsable de seguridad y documentado dentro del siguiente día hábil.

**Evidencia:** E2-privilegios.txt, bitácora PostgreSQL E5, instantáneas de privilegios MongoDB del LAB-02 y registro gobierno.solicitudes_cambio. Si no existe solicitud formal para un privilegio observado, se registra como hallazgo.

**Revisión:** mensual y después de incidentes o cambios organizacionales.
