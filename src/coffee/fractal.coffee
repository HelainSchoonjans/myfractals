"use strict"
class Fractal
  numberOfRows: 400
  numberOfColumns: 600
  canvas: null
  drawingContext: null
  epsilon: 0.0001
  maxIterations: 25
  cellSize: 1  # size of a pixel
  resolution: 150    # number of pixel per unit
  type: 'mandelbrot'    #circle or mandelbrot
  center_r: 0
  center_i: 0

  constructor: ->
    @createCanvas()
    @resizeCanvas()
    @createDrawingContext()
    @drawFractal()
  
  drawFractal: ->
    console.log "Begin generation with", @maxIterations, "iteration(s)"
    console.log "Centered at", @center_r, @center_i
    switch @type
      when 'circle' then @drawCircleFractal()
      when 'mandelbrot' then @drawMandelbrot()
    console.log "Finished"

  createCanvas: ->
    @canvas = document.createElement 'canvas'
    document.body.appendChild @canvas

  resizeCanvas: ->
    @canvas.height = @cellSize * @numberOfRows
    @canvas.width = @cellSize * @numberOfColumns

  createDrawingContext: ->
    @drawingContext = @canvas.getContext '2d'

  # inspired from http://natureofcode.com/book/chapter-8-fractals/
  drawCircle: (x, y, radius, iteration) ->
    @drawingContext.strokeStyle = "hsl(#{radius}, 60%, 50%)"
    @drawingContext.beginPath()
    @drawingContext.arc(x,y,radius,0,2*Math.PI)
    @drawingContext.stroke()
    if iteration < @maxIterations and radius > 1
      @drawCircle()
      @drawCircle(x + radius/2, y, radius/2, iteration+1)
      @drawCircle(x - radius/2, y, radius/2, iteration+1)
	
  # inspired from http://natureofcode.com/book/chapter-8-fractals/
  drawCircleFractal: ->
    for row in [0...@numberOfRows]
        for column in [0...@numberOfColumns]
          @drawCurrentPixel(row, column)
    
    @drawingContext.clearRect(0,0, @canvas.width, @canvas.height)
    @drawCircle(@numberOfColumns/2 + @center_r,@numberOfRows/2 + @center_i, @resolution, 0)

  drawMandelbrot: ->
    for row in [0...@numberOfRows]
        for column in [0...@numberOfColumns]
          @drawCurrentPixel(row, column)

  drawCurrentPixel: (row, column) ->
    iteration = 0
    r = (column - (@numberOfColumns / 2)) / @resolution + @center_r
    i = (row - (@numberOfRows / 2)) / @resolution + @center_i
    c = new Complex(r, i)
    z = new Complex(0,0)

    while iteration < @maxIterations && z.magnitude < 2
      z = z.times(z).plus(c)
      iteration = iteration + 1

    b = iteration * 360 / @maxIterations

    @drawingContext.fillStyle = "hsl(#{b}, 60%, 50%)"
    x = column*@cellSize
    y = @canvas.height - row * @cellSize
    @drawingContext.fillRect x, y, @cellSize, @cellSize
  
  changeType: ->
    @type = document.getElementById("type").value
    console.log "type", @type
    @drawFractal()

window.Fractal = Fractal