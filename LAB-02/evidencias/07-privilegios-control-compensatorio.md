# 07 — Privilegios y control compensatorio

## Resultado de referencia
La búsqueda de `grantRoles` en `system.profile` y en la bitácora devuelve `0` coincidencias. Las instantáneas muestran:

| Momento | Usuario | Roles de `app_ventas` |
|---|---|---|
| Primera instantánea | `admin` | `readWrite` sobre `comercial` |
| Segunda instantánea | `admin` | `readWrite` y `dbAdmin` sobre `comercial` |

El rol `dbAdmin` aparece en la segunda instantánea y no en la primera.

## Interpretación
La comparación demuestra que los privilegios cambiaron y permite identificar el rol agregado. No identifica quién ejecutó el cambio ni el instante exacto: solo acota que ocurrió entre las dos instantáneas.

## Preguntas
1. **¿Por qué es importante auditar cambios de privilegios?** Porque una modificación de roles puede ampliar el acceso, permitir operaciones administrativas y aumentar el impacto de una cuenta comprometida o mal utilizada.
2. **¿Cada cuánto tomar instantáneas?** Depende del riesgo, la frecuencia de cambios, el volumen de usuarios y el tiempo máximo aceptable para detectar una modificación. En sistemas críticos conviene combinarlas con controles de aprobación y auditoría nativa cuando esté disponible.
3. **¿Quién debería escribir en `auditoria.instantaneas_privilegios`?** Una cuenta de servicio dedicada y restringida, separada de las cuentas operativas, con permisos mínimos. El acceso de lectura también debe limitarse.
4. **Comunicación a Dirección (tres líneas):**
   > MongoDB Community permite comparar instantáneas y detectar que los roles de una cuenta cambiaron.  
   > Sin auditoría nativa, estas instantáneas no identifican al autor ni la hora exacta del cambio.  
   > Se recomienda restringir la administración de roles y evaluar una edición con auditoría si la atribución es un requisito.
