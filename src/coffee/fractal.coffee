"use strict"

#milestones
# add easy zoom
# add a way to center the stuff easily
# make more fractals
# clean code

class Fractal
  numberOfRows: 400
  numberOfColumns: 600
  canvas: null
  drawingContext: null
  epsilon: 0.0001
  maxIterations: 25
  cellSize: 1  # size of a pixel
  resolution: 150  # number of pixel per unit
  center_r: 0
  center_i: 0

  constructor: ->
    @createCanvas()
    @resizeCanvas()
    @createDrawingContext()
    @drawMandelbrot()

  createCanvas: ->
    @canvas = document.createElement 'canvas'
    document.body.appendChild @canvas

  resizeCanvas: ->
    @canvas.height = @cellSize * @numberOfRows
    @canvas.width = @cellSize * @numberOfColumns

  createDrawingContext: ->
    @drawingContext = @canvas.getContext '2d'

  drawMandelbrot: ->
    console.log "Begin generation with", @maxIterations, "iteration(s)"
    for row in [0...@numberOfRows]
        for column in [0...@numberOfColumns]
          @drawCurrentPixel(row, column)
    console.log "Finished"

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

  applyDeltaIterations: (delta) ->
    @maxIterations += delta
    @drawMandelbrot()

window.Fractal = Fractal
