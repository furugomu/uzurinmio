class PieChart
  constructor: (@canvas) ->
    @ctx = @canvas.getContext('2d')
    @data = []
    @radius = 100
    @cx = @canvas.width / 2;
    @cy = @canvas.height / 2;

  update: (data) ->
    @data = data

  increase: (name, n=1) ->
    @_get(name).value += n

  decreaseAll: (n) ->
    for x in @data
      x.value -= n

  _get: (name) ->
    for x in @data
      return x if x.name == name
    null

  draw: ->
    @ctx.clearRect(0, 0, @canvas.width, @canvas.height)
    offset = -Math.PI/2
    pi2 = Math.PI*2
    for [x, start, end] in @ranges()
      @drawSector(start*pi2+offset, end*pi2+offset, x.color)

  drawSector: (start, end, color) ->
    @ctx.fillStyle = color
    @ctx.beginPath()
    @ctx.moveTo(@cx, @cy)
    @ctx.arc(@cx, @cy, @radius, start, end)
    @ctx.lineTo(@cx, @cy)
    @ctx.fill()
    @ctx.closePath()

  sum: ->
    n = 0
    n += x.value for x in @data
    n

  ranges: ->
    a = []
    total = @sum()
    n = 0
    for x in @data
      a.push([x, n / total, (n+x.value) / total])
      n += x.value
    a

this.PieChart = PieChart
