# 01 — Calidad de datos

## Hallazgos identificados

| ID | Hallazgo | Registros | Regla de calidad | Quién decide la corrección | Acción propuesta |
|---|---|---:|---|---|---|
| C1 | Posible cliente duplicado por correo normalizado | 1 y 7 | Unicidad del correo, previa validación de identidad | Gerencia Comercial | Confirmar si es la misma persona; conservar un registro maestro y documentar la relación antes de fusionar |
| C2 | RFC con formato no válido | 7 | Formato sintáctico de RFC | Gerencia Comercial con validación de Facturación | Solicitar comprobante y validar el RFC; no inferir ni inventar caracteres |
| C3 | Correo con formato no válido | 8 | Estructura básica usuario@dominio | Gerencia Comercial | Confirmar correo con el cliente y corregir con autorización |
| C4 | Edad fuera de rango y teléfono incompleto | 8 | Edad entre 18 y 120 para este escenario; teléfono con longitud definida | Gerencia Comercial | Verificar fuente original y corregir solo con confirmación |

## Respuestas
1. El DBA no debe corregir el RFC por su cuenta porque es custodio técnico, no propietario del dato. No conoce necesariamente el documento fuente ni tiene autoridad para decidir el valor comercial/fiscal correcto.
2. `UNIQUE (lower(correo))` mediante índice único funcional podría prevenir duplicados normalizados, después de resolver los existentes. Un `CHECK` puede validar el formato básico de correo, RFC, edad y longitud de teléfono; las reglas deben aprobarse por Gerencia Comercial y Facturación. La expresión regular no certifica la validez ante el SAT.
3. Una corrección ejecutada sobre `clientes` debe quedar registrada por el disparador de auditoría de LAB-01 en `auditoria.cambios_clientes`, siempre que el disparador esté habilitado y el cambio no eluda el mecanismo.

## Evidencia relacionada
- Consultas: `../sql/01-verificaciones-calidad.sql`.
- Auditoría de modificaciones: `E4-muestra-auditoria.txt`.
- Configuración y bitácora: E1 y E5.
