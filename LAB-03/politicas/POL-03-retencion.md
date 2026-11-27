# POL-03 — Retención y eliminación

**Objetivo:** evitar tanto la pérdida prematura de evidencia como la conservación indefinida de datos personales.

**Alcance:** datos comerciales, auditorías de cambios, bitácoras de motores, perfiles, instantáneas de privilegios y exportaciones.

**Regla:** los registros de acceso se conservarán 12 meses; cambios de privilegios y estructura, 24 meses; modificaciones de datos y auditoría de clientes, 24 meses; perfiles operativos, 30 días; instantáneas de privilegios, 12 meses. Los datos personales sujetos a una obligación legal tendrán el plazo que confirme el área jurídica. Antes de eliminar evidencia vinculada con un incidente o investigación, se aplicará retención preventiva documentada.

**Responsable:** propietario del dato aprueba el plazo de los datos comerciales; Auditoría y Seguridad definen la necesidad probatoria; DBA aplica la disposición autorizada.

**Excepciones:** investigaciones, litigios, requerimientos de autoridad o retención legal; requieren autorización de Jurídico y Auditoría.

**Evidencia:** criterio en `evidencias/05-conservacion.md`, exportaciones E5 y E6, hashes SHA-256 y registro de disposición. Actualmente no se adjunta acta de eliminación.

**Revisión:** anual o cuando cambien obligaciones legales, riesgos o finalidades.
