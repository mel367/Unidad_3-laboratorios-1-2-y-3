# 06 — Conciliación de cambios

## Matriz de conciliación

| Momento / referencia | Usuario | Sentencia | Folio | ¿Autorizado? | Hallazgo |
|---|---|---|---|---|---|
| Evento 216 (fragmento de guía) | postgres | ALTER TABLE clientes ADD COLUMN canal_alta VARCHAR(20) | CAM-2026-014 | Sí, dentro de ventana | Sin hallazgo, sujeto a validar hora real y folio |
| Evento 163 (fragmento de guía) | app_ventas | ALTER TABLE clientes DISABLE TRIGGER trg_auditoria_clientes | No identificado | No | Alto: cuenta de aplicación intentó deshabilitar auditoría |
| Evento 169 (fragmento de guía) | postgres | ALTER TABLE clientes DISABLE TRIGGER trg_auditoria_clientes | No identificado | No identificado | Alto: operación privilegiada deshabilitó el disparador; requiere justificación y autorización |
| Evento 171 (fragmento de guía) | postgres | ALTER TABLE clientes ENABLE TRIGGER trg_auditoria_clientes | No identificado | No identificado | La auditoría fue reactivada; no elimina el intervalo sin cobertura |
| Evento 35 (fragmento de guía) | postgres | GRANT UPDATE ON clientes TO app_ventas | No identificado | Pendiente | Medio/alto: validar matriz de roles y solicitud aprobada |
| Evento 34 (fragmento de guía) | postgres | REVOKE UPDATE ON clientes FROM soporte_ana | No identificado | Pendiente | Confirmar que la revocación corresponda a solicitud y rol vigente |

## Interpretación
- El cambio `canal_alta` está asociado a CAM-2026-014 y la consulta de ventana del instructivo devuelve `true`. La autorización debe confirmarse con la marca temporal real de ejecución.
- La línea 163 corresponde a `app_ventas`, una cuenta de aplicación que no debería tener capacidad para alterar estructura o deshabilitar triggers. Es un hallazgo crítico para la separación de funciones.
- La línea 169 muestra que la operación también fue ejecutada por `postgres`, cuenta administrativa. Aunque el DBA tenga capacidad técnica, debe existir autorización y ventana. La línea 171 indica reactivación, pero no restaura retroactivamente los eventos que pudieron quedar sin auditar.
- Los cambios sin folio pueden corresponder a preparación del laboratorio, pero deben quedar identificados como tales y no declararse autorizados sin registro.

## Limitaciones
Si `log_statement` estuvo en `none`, las sentencias ejecutadas durante ese intervalo no aparecen en la bitácora de sentencias. La conciliación solo cubre lo registrado y disponible; no demuestra que no ocurrieron otros cambios.

La conciliación debe realizarla Auditoría o un revisor independiente del DBA que ejecutó los cambios.
