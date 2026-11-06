# Informe — LAB-02: Trazabilidad en MongoDB Community

## 1. Despliegue, edición y limitación
El laboratorio toma como referencia MongoDB 7.0.43 Community. El resultado mostrado para `buildInfo.modules` es un arreglo vacío, lo que permite documentar que no se está usando el módulo Enterprise. La auditoría nativa de MongoDB no está disponible en Community; por ello se trabaja con Database Profiler y la bitácora de `mongod`.

## 2. Perfilador
El perfilador se encontraba apagado al inicio. En esa condición, la actualización del RFC produjo una respuesta de modificación, pero no dejó un documento en `system.profile`. Al activar nivel 2 se registraron consultas, actualizaciones y eliminaciones con datos como operación, espacio de nombres, usuario, cliente, aplicación, momento y cantidad de documentos afectados.

El nivel 2 ofrece mayor visibilidad, pero también aumenta el volumen, el consumo de almacenamiento y el riesgo de registrar filtros con datos sensibles. El perfilador fue diseñado para analizar rendimiento, no para sustituir una auditoría de seguridad.

## 3. Bitácora de mongod
La bitácora permite observar conexiones, autenticaciones fallidas y exitosas, así como cambios de configuración del perfilador. El campo `ctx` permite correlacionar el cambio de configuración con la conexión autenticada como `admin`, siempre que ambos eventos pertenezcan al mismo periodo de ejecución del servidor.

`getLog` entrega eventos recientes en memoria y no equivale a un archivo histórico completo. La ubicación persistente depende de `systemLog.destination` y `systemLog.path`.

## 4. Privilegios
Las instantáneas comparadas muestran que a `app_ventas` se le agregó el rol `dbAdmin`. Esta medida detecta diferencias entre estados, pero no permite conocer por sí sola quién realizó el cambio ni el momento exacto. Es un control compensatorio, no una auditoría equivalente.

Se recomienda limitar quién puede modificar roles, mantener una cuenta administrativa separada, proteger la colección de instantáneas y establecer revisiones periódicas. Si la organización necesita atribución detallada de cambios de privilegios, debe evaluar MongoDB Enterprise o Atlas con auditoría habilitada, considerando costos y requisitos operativos.

## 5. Conservación
La colección `system.profile` tiene tamaño limitado y puede sobrescribir registros antiguos. La memoria de `getLog` contiene solo eventos recientes y se pierde al reiniciar. El nivel de perfilado configurado desde mongosh tampoco persiste tras el reinicio. Por eso es importante exportar las evidencias y calcular sus hashes antes de limpiar o reiniciar.

## 6. Comparación
MongoDB Community permite trazabilidad parcial mediante perfilador y bitácora, pero no ofrece auditoría nativa. PostgreSQL, según el LAB-01, combina registros del servidor y mecanismos sobre los datos. Enterprise/Atlas agrega auditoría nativa para categorías de eventos documentadas por MongoDB. La comparación exacta con PostgreSQL debe conservar los resultados comprobados en el LAB-01.

## 7. Recomendación
Para una organización que necesita atribuir cambios de privilegios, no recomendaría depender únicamente de instantáneas en MongoDB Community. Como medida inmediata, restringiría la administración de roles, separaría cuentas, protegería las instantáneas y conservaría bitácoras en almacenamiento persistente. Si la atribución individual y detallada es un requisito formal, evaluaría Enterprise o Atlas con auditoría nativa, después de comparar costo, retención, volumen y cumplimiento.

## 8. Preguntas de reflexión
1. **¿Por qué el perfilador no debe presentarse como auditoría de seguridad?** Porque su propósito principal es analizar rendimiento y no garantiza cobertura, atribución y conservación propias de una auditoría.
2. **¿Por qué sí aporta trazabilidad?** Porque registra operaciones y permite relacionar usuario, cliente, aplicación, momento y tipo de operación mientras está activo.
3. **¿Qué riesgo introduce el nivel 2?** Puede registrar filtros y valores que revelen datos personales, además de generar volumen y afectar el rendimiento.
4. **¿Diferencia entre detectar y atribuir?** Detectar permite reconocer que ocurrió un cambio; atribuir requiere evidencia que relacione ese cambio con una identidad y un momento confiables.
5. **¿Por qué reconocer limitaciones es profesional?** Porque evita afirmar capacidades inexistentes, permite comunicar riesgos reales y ayuda a elegir controles compensatorios adecuados.

## Alcance de los resultados
Los ejemplos de salida y marcas de tiempo de este informe se basan en los resultados de referencia incluidos en el instructivo del laboratorio. No se afirma que se haya ejecutado MongoDB en el equipo local. Las exportaciones adjuntas son muestras organizadas a partir de esos resultados; una ejecución real debe producir sus propios archivos y hashes.
