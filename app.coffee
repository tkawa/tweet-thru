express = require 'express'
routes = require './routes'

app = module.exports = express.createServer()
coffee = require 'coffee-script'
hamljs = require 'hamljs'
io = require('socket.io').listen(app)
TwitterNode = require('twitter-node').TwitterNode

# Configuration

io.configure ->
  io.set "transports", ["xhr-polling"] # WebSocket doesn't work on Heroku
  io.set "polling duration", 10

app.configure ->
  app.set 'views', __dirname + '/views'
#  app.set('view engine', 'jade')
#  app.use(express.bodyParser())
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + '/public')

app.configure 'development', ->
  app.use express.errorHandler( dumpExceptions: true, showStack: true )

app.configure 'production', ->
  app.use express.errorHandler()

app.register '.haml', hamljs
hamljs.filters.coffee = (str) ->
  @javascript coffee.compile(str)

# Twitter
twitter = new TwitterNode(
  user: process.env.TWITTER_USER,
  password: process.env.TWITTER_PASSWORD,
  action: 'sample'
)

twitter
  .addListener 'tweet', (tweet) ->
    io.sockets.json.emit 'tweet', tweet
  .addListener 'error', (error) ->
    console.log error.message
  .stream()

# Socket.io
#io.sockets.on 'connection', (socket) ->
#  console.log 'socket connected'
#  socket.on 'msg send', (msg) ->
#    socket.emit 'msg push', msg
#    socket.broadcast.emit 'msg push', msg
#  socket.on 'disconnect', () ->
#    console.log 'socket disconnected'

# Routes
app.get('/', routes.index)

app.listen process.env.PORT || 3000
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
