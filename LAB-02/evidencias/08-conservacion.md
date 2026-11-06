# 08 — Conservación y exportación

## Resultados de referencia
Después del reinicio, el perfilador vuelve al nivel `0`; los documentos ya registrados pueden permanecer en `system.profile`. La memoria consultable mediante `getLog` se reduce o se vacía al reiniciar. El instructivo muestra la exportación de `system.profile` y de los eventos recientes de `mongod`.

## Preguntas
1. **Tres formas de perder evidencia sin borrado deliberado:**
   - La colección limitada `system.profile` sobrescribe documentos antiguos al llenarse.
   - La memoria de `getLog` conserva solo eventos recientes y se vacía al reiniciar.
   - El perfilado configurado temporalmente desde mongosh no conserva su nivel tras reiniciar; además, si no se exporta el contenido antes de limpiar o sobrescribir, se pierde.
2. **¿Por qué 1 MB es un problema de conservación?** Porque limita la cantidad de operaciones históricas disponibles; al llenarse, los documentos antiguos se reemplazan y puede desaparecer evidencia relevante.
3. **¿Por qué `getLog` sirve para interpretar pero no conservar?** Porque devuelve una ventana limitada de eventos recientes almacenados en memoria, no el archivo completo e histórico de la bitácora.

## Exportaciones
`system-profile.json` y `bitacora-mongod.log` incluidos en este paquete contienen fragmentos de referencia basados en los resultados presentados en el instructivo. Para una exportación real deben generarse desde el servidor y calcularse de nuevo sus hashes.
