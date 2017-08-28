var jsonServer = require("json-server")
var server = jsonServer.create()

server.use(jsonServer.defaults())

var path = require("path")
var router = jsonServer.router(path.join(__dirname, "db.json"))
server.use(router)

console.log("Listening on 4000")
server.listen(4000)
