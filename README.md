# LAB-01 — Bitácoras y auditoría del dato en PostgreSQL

**Materia:** Gestión de Seguridad y Desempeño de Bases de Datos  
**Unidad:** III — Auditoría, trazabilidad y gobierno práctico de datos  
**Motor de referencia:** PostgreSQL 16

## Aviso importante sobre esta entrega

Este paquete incluye **resultados simulados con fines académicos** para mostrar cómo se verían las evidencias. No se ejecutó PostgreSQL para producirlos. Por tanto, las fechas, PID, IP, mensajes de bitácora, conteos y valores son ficticios. No presentes la bitácora simulada como si hubiera sido extraída de tu servidor.

El hash SHA-256 incluido sí está calculado correctamente, pero corresponde únicamente al archivo de bitácora simulado de este paquete; no demuestra integridad de una bitácora real.

## Contenido

- `sql/`: seis scripts SQL base del laboratorio.
- `evidencias/01` a `15`: evidencias explicativas con resultados de ejemplo y respuestas.
- `evidencias/bitacora-lab01.log`: bitácora de ejemplo, expresamente identificada como simulación.
- `evidencias/bitacora-lab01.sha256`: hash del archivo simulado.
- `evidencias/16-pgaudit.md`: sección opcional, no desarrollada como ejecución real.
- `informe.md`: informe con resultados de ejemplo identificados como simulados.

## Entorno de referencia de la simulación

- Sistema operativo de referencia: Windows 11.
- Despliegue supuesto: instalación local de PostgreSQL 16.
- Base de datos: `comercial`.
- Cliente: `psql` / pgAdmin 4.
- Roles de práctica: `postgres`, `app_ventas`, `soporte_ana`.

Estos datos describen el escenario de ejemplo, no una instalación verificada en el equipo del estudiante.

## Orden sugerido si posteriormente se valida en un servidor real

1. Verificar `SELECT version();` y la base `comercial`.
2. Preparar la tabla `clientes`, los cinco registros ficticios y los roles de la guía.
3. Ejecutar los scripts SQL en el orden indicado en la guía.
4. Realizar las pruebas de conexión, privilegios, errores y modificaciones.
5. Exportar la bitácora real, revisar y redactar secretos.
6. Calcular de nuevo SHA-256 sobre el archivo real depurado.

## Seguridad

No subas contraseñas ni cadenas de conexión con credenciales. Revisa toda bitácora antes de compartirla, porque puede contener datos personales o secretos.
