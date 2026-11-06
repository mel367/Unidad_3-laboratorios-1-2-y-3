// LAB-02 — comandos de referencia para mongosh
// Ejecutar por bloques y con el usuario indicado en el instructivo.
// No ejecutar todo el archivo de una sola vez: algunas actividades dependen
// de resultados anteriores y la Actividad 7 modifica roles temporalmente.

// Preparación inicial (solo si el servidor está recién creado):
use admin
db.createUser({ user: "admin", pwd: "Admin_Practica_2026", roles: ["root"] })
db.auth("admin", "Admin_Practica_2026")

use comercial
db.createUser({
  user: "app_ventas",
  pwd: "Ventas_Practica_2026",
  roles: [{ role: "readWrite", db: "comercial" }]
})
db.clientes.insertMany([
  { _id: 1, nombre: "Ana López", correo: "ana.lopez@example.test", telefono: "6671234567", rfc: "LOAA850315ABC", edad: 41, ciudad: "Culiacán", codigo_postal: "80000" },
  { _id: 2, nombre: "Carlos Pérez", correo: "carlos.perez@example.test", telefono: "6672345678", rfc: "PECA900720DEF", edad: 35, ciudad: "Culiacán", codigo_postal: "80100" },
  { _id: 3, nombre: "María García", correo: "maria.garcia@example.test", telefono: "6673456789", rfc: "GAMA780912GHI", edad: 47, ciudad: "Mazatlán", codigo_postal: "82000" },
  { _id: 4, nombre: "Luis Torres", correo: "luis.torres@example.test", telefono: "6674567890", rfc: "TOLU920201JKL", edad: 34, ciudad: "Los Mochis", codigo_postal: "81200" },
  { _id: 5, nombre: "Laura Sánchez", correo: "laura.sanchez@example.test", telefono: "6675678901", rfc: "SALA880525MNO", edad: 38, ciudad: "Culiacán", codigo_postal: "80200" }
])

// Función auxiliar para consultar eventos recientes:
function bitacora() {
  return db.adminCommand({ getLog: "global" }).log.map(l => JSON.parse(l))
}

// Actividad 1 — edición y configuración:
db.version()
db.adminCommand({ buildInfo: 1 }).modules
db.serverCmdLineOpts().parsed

// Actividad 2 — incidente con perfilador apagado:
db.getProfilingStatus()
db.system.profile.countDocuments()

// Ejecutar desde la sesión app_ventas:
// db.clientes.updateOne({ _id: 3 }, { $set: { rfc: "GAMA780912XXX" } })

// Actividad 3 — perfilado nivel 2:
db.setProfilingLevel(2)
db.getProfilingStatus()

// Ejecutar desde la sesión app_ventas:
// db.clientes.find({ ciudad: "Culiacán" }, { nombre: 1, ciudad: 1 }).toArray()
// db.clientes.updateOne({ _id: 3 }, { $set: { rfc: "GAMA780912XYZ" } })
// db.clientes.deleteOne({ _id: 2 })

db.system.profile.find(
  { ns: "comercial.clientes" },
  { op: 1, ns: 1, command: 1, user: 1, client: 1, appName: 1, ts: 1, millis: 1, nreturned: 1, docsExamined: 1, nModified: 1, ndeleted: 1 }
).sort({ ts: 1 })

// Actividad 4 — filtro de operaciones de escritura:
db.setProfilingLevel(0)
db.system.profile.drop()
db.setProfilingLevel(1, { filter: { op: { $in: ["insert", "update", "remove"] } } })
db.getProfilingStatus()
db.system.profile.find({}, { op: 1, ns: 1, user: 1, appName: 1, "command.q": 1, "command.u": 1, ts: 1 })

// Actividad 5 — accesos:
bitacora()
  .filter(e => e.c === "ACCESS" && e.msg === "Failed to authenticate")
  .map(e => ({ t: e.t, id: e.id, ctx: e.ctx, user: e.attr.user, client: e.attr.client, error: e.attr.error, result: e.attr.result, app: e.attr.doc.application.name }))

bitacora()
  .filter(e => e.msg === "Successfully authenticated" && e.attr.user === "app_ventas")
  .slice(-1)
  .map(e => ({ t: e.t, id: e.id, ctx: e.ctx, client: e.attr.client, result: e.attr.result, app: e.attr.doc.application.name }))

// Actividad 6 — correlación por contexto:
bitacora()
  .filter(e => e.msg === "Profiler settings changed")
  .map(e => ({ t: e.t, ctx: e.ctx, msg: e.msg, attr: e.attr }))

// Sustituir conn31 por el contexto obtenido en la propia bitácora:
bitacora()
  .filter(e => e.ctx === "conn31" && e.msg === "Successfully authenticated")
  .map(e => ({ t: e.t, ctx: e.ctx, user: e.attr.user, db: e.attr.db, client: e.attr.client }))

// Actividad 7 — instantáneas de privilegios:
db.getSiblingDB("auditoria").instantaneas_privilegios.insertOne({
  momento: new Date(),
  tomada_por: db.runCommand({ connectionStatus: 1 }).authInfo.authenticatedUsers,
  usuarios: db.getUsers().users.map(u => ({ user: u.user, db: u.db, roles: u.roles }))
})

db.setProfilingLevel(2)
db.grantRolesToUser("app_ventas", [{ role: "dbAdmin", db: "comercial" }])

db.system.profile.countDocuments({ "command.grantRolesToUser": { $exists: true } })
bitacora().filter(e => JSON.stringify(e).includes("grantRoles")).length

// Tomar segunda instantánea y comparar:
db.getSiblingDB("auditoria").instantaneas_privilegios.find({}, { _id: 0 }).sort({ momento: 1 })

// Revertir el rol temporal y restaurar el filtro:
db.revokeRolesFromUser("app_ventas", [{ role: "dbAdmin", db: "comercial" }])
db.setProfilingLevel(1, { filter: { op: { $in: ["insert", "update", "remove"] } } })

// Actividad 8 — exportaciones desde la terminal, no desde el prompt interactivo:
// mongosh "<URI-ADMIN>" --quiet --eval 'EJSON.stringify(db.system.profile.find({}, { op: 1, ns: 1, user: 1, client: 1, appName: 1, ts: 1, "command.q": 1, "command.u": 1 }).toArray(), null, 2)' > evidencias/system-profile.json
// mongosh "<URI-ADMIN>" --quiet --eval 'db.adminCommand({ getLog: "global" }).log.join("\n")' > evidencias/bitacora-mongod.log
// Después calcular SHA-256 de ambos archivos.

// Nota: los ejemplos de conexión y contraseñas son exclusivos del laboratorio.
// No reutilizar estas credenciales fuera del entorno de práctica.
