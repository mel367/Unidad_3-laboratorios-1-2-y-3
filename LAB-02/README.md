# LAB-02 — Trazabilidad en MongoDB Community

**Materia:** Gestión de Seguridad y Desempeño de Bases de Datos  
**Unidad:** III — Auditoría, trazabilidad y gobierno práctico de datos  
**Motor de referencia:** MongoDB 7 Community Edition

## Objetivo
Documentar los mecanismos de trazabilidad disponibles en MongoDB Community, interpretar el perfilador y la bitácora de `mongod`, e identificar las limitaciones de esta edición.

## Entorno y alcance
El instructivo de la práctica presenta resultados observados con MongoDB 7.0.43 Community y mongosh 2.10.0. Este paquete organiza esos resultados de referencia para desarrollar las evidencias y respuestas. No representa una ejecución realizada en el equipo local.

## Estructura
- `evidencias/`: diez evidencias, exportaciones de referencia y hashes.
- `scripts/comandos-mongosh.js`: comandos organizados por actividad.
- `informe.md`: análisis y conclusiones del laboratorio.

## Despliegue
La guía permite instalación nativa, máquina virtual o contenedor. Para este documento se toma como entorno de referencia MongoDB 7 Community. No se afirma un despliegue local ni se atribuyen al equipo local las direcciones, conexiones o marcas de tiempo de los ejemplos.

## Nota sobre la edición
MongoDB Community no incluye auditoría nativa. La trazabilidad se apoya en Database Profiler y en los mensajes de `mongod`; ninguno equivale a auditoría nativa.

## Integridad
`evidencias/hashes.sha256` contiene los SHA-256 calculados sobre los archivos de referencia incluidos en este paquete. Si se reemplaza o modifica cualquiera de esos archivos, se deben volver a calcular los hashes.
