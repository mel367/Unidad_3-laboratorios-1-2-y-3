# LAB-03 — Políticas prácticas, gobierno de datos y evidencias

**Materia:** Gestión de Seguridad y Desempeño de Bases de Datos  
**Unidad:** III — Auditoría, trazabilidad y gobierno práctico de datos  
**Motores:** PostgreSQL 16 y MongoDB 7  
**Organización del escenario:** Comercializadora Norte S.A. de C.V.

## Contenido
- `EXPEDIENTE.md`: integración para auditoría interna.
- `sql/`: consultas de calidad, comentarios, inventario y solicitudes de cambio.
- `politicas/`: seis políticas prácticas.
- `evidencias/`: matrices, catálogo, diccionario y evidencias técnicas de referencia.

## Uso
Ejecutar los scripts SQL en el orden indicado, con una cuenta administradora sobre la base `comercial`. Revisar previamente si los objetos ya existen para evitar duplicados. Los comandos de exportación y cálculo de hashes se describen en las evidencias correspondientes.

Los archivos E1–E6 incluidos contienen salidas de referencia y fragmentos del escenario proporcionado por la guía. Deben sustituirse por las exportaciones del servidor y del LAB-02 antes de presentarlos como evidencia de ejecución. No se incluyen fotografías porque la guía no las solicita.

## Orden recomendado
1. Revisar `evidencias/01-calidad.md` y ejecutar `sql/01-verificaciones-calidad.sql`.
2. Ejecutar `sql/02-comentarios-diccionario.sql` y exportar el CSV.
3. Ejecutar `sql/03-inventario-tablas.sql` y completar el catálogo.
4. Leer las seis políticas.
5. Ejecutar `sql/04-registro-cambios.sql` en una ventana autorizada.
6. Generar E1–E5 desde PostgreSQL y copiar E6 desde LAB-02.
7. Actualizar `EXPEDIENTE.md` con los identificadores, fechas y resultados definitivos.
