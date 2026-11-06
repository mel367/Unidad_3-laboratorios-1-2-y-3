# 05 — Accesos en la bitácora de mongod

## Eventos de referencia
Se presentan dos intentos fallidos:
- Usuario `app_ventas` con contraseña incorrecta.
- Usuario inexistente `usuario_inexistente`.

Ambos reciben `MongoServerError: Authentication failed.` desde el cliente.

## Interpretación
La bitácora diferencia los motivos:
- `AuthenticationFailed`: la cuenta existe, pero la autenticación no se completó con las credenciales proporcionadas.
- `UserNotFound`: no se encontró el usuario en la base de autenticación indicada.

El cliente recibe un mensaje general de autenticación fallida para no revelar fácilmente si una cuenta existe. En el ejemplo, el evento exitoso tiene resultado `0`; los fallidos muestran códigos de error distintos (`18` y `11`).

## Preguntas
1. **¿Qué campo distingue el acceso?** El resultado (`attr.result`) y el mensaje del evento permiten distinguir éxito y fallo. `Successfully authenticated` indica éxito; `Failed to authenticate` indica fallo.
2. **¿Diferencia entre contraseña incorrecta y usuario inexistente?** La primera produce `AuthenticationFailed`; la segunda `UserNotFound`. El mensaje del cliente se mantiene genérico para reducir la enumeración de usuarios.
3. **¿Por qué aparece `mongosh 2.10.0` y no `app-ventas-web`?** Porque los intentos fallidos se hicieron directamente desde mongosh sin el parámetro `appName=app-ventas-web`. La aplicación exitosa sí se identifica con su `appName`.
4. **¿Por qué no contar líneas como intentos?** Un mismo intento puede producir más de un evento de autenticación, por lo que deben agruparse y analizarse por contexto y atributos.
