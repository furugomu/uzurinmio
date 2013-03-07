exports = this
jQuery ($) ->
  canvas = document.getElementById("canvas")
  chart = new PieChart(document.getElementById("canvas"))
  exports.chart = chart
  chart.radius = canvas.height / 2

  socket = io.connect(location.host)
  socket.on "update", (data) ->
    console.log(data)
    chart.update(data)
    chart.draw()

  socket.on "increased", (name) ->
    chart.increase(name)
    chart.draw()

  $(".vote").on "click touchend", ->
    socket.emit("increase", @name)
    false

