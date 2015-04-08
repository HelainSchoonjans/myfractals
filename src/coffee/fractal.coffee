# from http://rosettacode.org/wiki/Arithmetic/Complex#CoffeeScript
# create an immutable Complex type
class Complex
  constructor: (@r=0, @i=0) ->
    @magnitude = @r*@r + @i*@i
 
  plus: (c2) ->
    new Complex(
      @r + c2.r,
      @i + c2.i
    )
 
  times: (c2) ->
    new Complex(
      @r*c2.r - @i*c2.i,
      @r*c2.i + @i*c2.r
    )
 
  negation: ->
    new Complex(
      -1 * @r,
      -1 * @i
    )
 
  inverse: ->
    throw Error "no inverse" if @magnitude is 0
    new Complex(
      @r / @magnitude,
      -1 * @i / @magnitude
    )
 
  toString: ->
    return "#{@r}" if @i == 0
    return "#{@i}i" if @r == 0
    if @i > 0
      "#{@r} + #{@i}i"
    else
      "#{@r} - #{-1 * @i}i"

#milestones
# add easy zoom
# add a way to center the stuff easily
# make more fractals
# clean code

class Fractal
  numberOfRows: 1000
  numberOfColumns: 1000
  canvas: null
  drawingContext: null
  epsilon: 0.0001
  maxIterations: 25
  cellSize: 1

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
    for row in [0...@numberOfRows]
        for column in [0...@numberOfColumns]
          @drawCurrentPixel(row, column)

  drawCurrentPixel: (row, column) ->
    iteration = 0
    c = new Complex(row*2 / 300 - 3, column*2 / 300 - 3)
    z = new Complex(0,0)

    while iteration < @maxIterations && z.magnitude < 2
      z = z.times(z).plus(c)
      iteration = iteration + 1

    b = iteration * 360 / @maxIterations

    @drawingContext.fillStyle = "hsl(#{b}, 60%, 50%)"
    @drawingContext.fillRect row*@cellSize, column*@cellSize, @cellSize, @cellSize



window.Fractal = Fractal