# 10 — Respuesta a Dirección

## 1. ¿Quién cambió el RFC de María García en la Actividad 2 y en la Actividad 3?
- **Actividad 2:** No hay evidencia con esta edición y con el perfilador apagado. La respuesta de la actualización confirma que un documento fue modificado, pero las fuentes consultadas no conservaron el detalle de la operación.
- **Actividad 3:** el perfilador identifica a `app_ventas@comercial`, desde `127.0.0.1` y la aplicación `app-ventas-web`, como ejecutor de la actualización registrada.

## 2. ¿Cuándo y desde qué aplicación?
En la Actividad 3, el registro de actualización aparece en `2026-10-25T22:52:45.909Z`, desde `app-ventas-web`, cliente `127.0.0.1`. En la Actividad 2 no existe evidencia suficiente para determinarlo.

## 3. ¿Qué valor tenía antes?
No hay evidencia con esta edición en el registro del perfilador mostrado. El documento del perfilador conserva la operación y el valor nuevo enviado, pero no una copia automática del valor anterior.

## 4. ¿Cambió alguien los privilegios de `app_ventas`?
Sí. La comparación de instantáneas muestra que se agregó el rol `dbAdmin` a `app_ventas`. Sin embargo, no hay evidencia con esta edición para identificar quién hizo el cambio ni la hora exacta. La comparación solo lo sitúa entre las dos instantáneas.
