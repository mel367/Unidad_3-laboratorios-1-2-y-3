-- LAB-03 / Actividad 3: diccionario operativo mediante COMMENT
-- Ejecutar después de verificar la estructura real de public.clientes.

COMMENT ON TABLE public.clientes IS
'Clientes de Comercializadora Norte. Propietario: Gerencia Comercial. Custodio: DBA. Clasificación: confidencial; contiene datos personales.';

COMMENT ON COLUMN public.clientes.id IS
'Identificador interno del cliente. Generado por el sistema. No debe reutilizarse.';

COMMENT ON COLUMN public.clientes.nombre IS
'Nombre completo del cliente. Dato personal identificador directo. Uso: atención y operación comercial.';

COMMENT ON COLUMN public.clientes.correo IS
'Correo de contacto. Dato personal. Uso: comunicaciones y notificaciones autorizadas.';

COMMENT ON COLUMN public.clientes.telefono IS
'Teléfono de contacto. Dato personal. Uso: comunicación operativa con el cliente.';

COMMENT ON COLUMN public.clientes.rfc IS
'RFC del cliente. Dato personal. Uso: facturación. Las correcciones requieren aprobación de Gerencia Comercial y quedan sujetas a auditoría.';

COMMENT ON COLUMN public.clientes.edad IS
'Edad en años cumplidos. Dato personal. Uso: análisis estadístico; preferir resultados agregados.';

COMMENT ON COLUMN public.clientes.ciudad IS
'Ciudad de residencia o ubicación comercial declarada. Dato personal indirecto. Uso: segmentación geográfica y atención.';

COMMENT ON COLUMN public.clientes.codigo_postal IS
'Código postal asociado al domicilio o ubicación declarada. Dato personal indirecto. Uso: cobertura y facturación cuando corresponda.';

COMMENT ON COLUMN public.clientes.fecha_alta IS
'Fecha de incorporación del cliente al sistema. Metadato operativo; uso: seguimiento de antigüedad y trazabilidad.';

COMMENT ON COLUMN public.clientes.segmento IS
'Clasificación comercial asignada al cliente. Uso interno; su modificación requiere criterio de Gerencia Comercial.';

-- Las columnas añadidas en actividades posteriores deben documentarse también.
-- Ejecutar únicamente si canal_alta ya existe:
-- COMMENT ON COLUMN public.clientes.canal_alta IS
-- 'Canal por el que se registró el cliente. Cambio asociado a CAM-2026-014.';
