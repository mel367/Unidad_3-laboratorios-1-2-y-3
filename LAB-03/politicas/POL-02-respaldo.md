# POL-02 — Respaldo de información

**Objetivo:** asegurar que la organización pueda recuperar información ante fallas, errores humanos o incidentes.

**Alcance:** bases PostgreSQL y MongoDB, configuraciones relevantes, diccionarios, catálogos, bitácoras y registros de auditoría.

**Regla:** la información transaccional de producción debe respaldarse diariamente y conservarse una copia separada del servidor principal. La restaurabilidad se comprobará mediante pruebas periódicas documentadas; no basta con confirmar que el archivo existe.

**Responsable:** propietario del dato determina criticidad y objetivos de recuperación; DBA define y ejecuta el esquema técnico; Auditoría revisa los resultados.

**Excepciones:** únicamente conjuntos temporales no productivos, con aceptación escrita del propietario y fecha de vencimiento.

**Evidencia:** actualmente LAB-01 y LAB-02 documentan auditoría y trazabilidad, pero no acreditan un ciclo completo de respaldos y restauraciones. El registro formal de respaldos deberá incorporarse cuando se implemente el procedimiento.

**Revisión:** trimestral y después de cambios importantes.

**Nota:** El procedimiento técnico se definirá en la Unidad V.
