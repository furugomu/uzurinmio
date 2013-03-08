express = require('express')
app = express()
server = require('http').createServer(app)
io = require('socket.io').listen(server)

app.configure ->
  app.set('port', process.env.PORT || 13594)
  app.use(express.favicon())
  app.use(express.static(__dirname + '/public'))

app.get '/', (req, res) ->
  res.sendfile(__dirname + '/public/index.html')

server.listen app.get('port'), ->
  console.log("Listening on " + app.get('port'))

##

data = [
  {name: 'm', value: 100, color: '#FFF280'},
  {name: 'r', value: 100, color: '#6EB7DB'},
  {name: 'u', value: 100, color: '#DB7BB1'},
]

get = (name) ->
  for x in data
    return x if x.name == name
  null

io.sockets.on "connection", (socket) ->
  socket.emit("update", data)
  socket.on "increase", (name) ->
    return unless get(name)
    for x in data
      if x.name == name
        x.value += 2
      else
        x.value -= 1 if x.value > 0
    io.sockets.emit("update", data)

# heroku
io.configure ->
  io.set("transports", ["xhr-polling"])
  io.set("polling duration", 10)
