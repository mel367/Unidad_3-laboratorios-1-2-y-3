# POL-05 — Uso de datos sensibles

**Objetivo:** limitar la exposición de datos personales y mantener trazabilidad de su consulta o modificación.

**Alcance:** nombre, correo, teléfono, RFC, edad, ciudad, código postal y cualquier dato derivado que permita identificar a un cliente, tanto en PostgreSQL como en MongoDB.

**Regla:** solo usuarios con función autorizada accederán a datos personales y deberán tener una finalidad laboral documentada. Para soporte se utilizarán vistas enmascaradas o datos mínimos; las correcciones de RFC requieren aprobación de Gerencia Comercial. Las modificaciones cubiertas por el disparador deben conservar usuario, fecha, operación e identificador del cliente.

**Responsable:** Gerencia Comercial es propietaria de los datos; DBA custodia y aplica controles; Seguridad y Auditoría revisan accesos y eventos.

**Excepciones:** atención de incidentes o requerimientos formales, con autorización, alcance limitado y registro de la causa.

**Evidencia:** E2-privilegios.txt, E3-disparadores.txt, E4-muestra-auditoria.txt, E5-bitacora-postgresql.log y evidencias de perfilado/privilegios del LAB-02. Las lecturas no cubiertas por auditoría nativa o pgaudit se reconocen como limitación.

**Revisión:** trimestral.
