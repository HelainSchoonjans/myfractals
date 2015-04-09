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
  numberOfRows: 400
  numberOfColumns: 600
  canvas: null
  drawingContext: null
  epsilon: 0.0001
  maxIterations: 25
  cellSize: 1  # size of a pixel
  resolution: 150    # number of pixel per unit
  type: 'mandelbrot'    #circle or mandelbrot

  constructor: ->
    @createCanvas()
    @resizeCanvas()
    @createDrawingContext()
    @drawFractal()
  
  drawFractal: ->
    switch @type
      when 'circle' then @drawCircleFractal()
      when 'mandelbrot' then @drawMandelbrot()
  
  createCanvas: ->
    @canvas = document.createElement 'canvas'
    document.body.appendChild @canvas

  resizeCanvas: ->
    @canvas.height = @cellSize * @numberOfRows
    @canvas.width = @cellSize * @numberOfColumns

  createDrawingContext: ->
    @drawingContext = @canvas.getContext '2d'

  # inspired from http://natureofcode.com/book/chapter-8-fractals/
  drawCircle: (x, y, radius) ->
    @drawingContext.strokeStyle = "hsl(#{radius}, 60%, 50%)"
    @drawingContext.beginPath()
    @drawingContext.arc(x,y,radius,0,2*Math.PI)
    @drawingContext.stroke()
    if radius > 2
      @drawCircle()
      @drawCircle(x + radius/2, y, radius/2)
      @drawCircle(x - radius/2, y, radius/2)
	
  # inspired from http://natureofcode.com/book/chapter-8-fractals/
  drawCircleFractal: ->
    @drawingContext.clearRect(0,0, @canvas.width, @canvas.height)
    @drawCircle(@numberOfColumns/2,@numberOfRows/2, 200)

  drawMandelbrot: ->
    console.log "Begin generation with", @maxIterations, "iteration(s)"
    for row in [0...@numberOfRows]
        for column in [0...@numberOfColumns]
          @drawCurrentPixel(row, column)
    console.log "Finished"

  drawCurrentPixel: (row, column) ->
    iteration = 0
    r = (column - @numberOfColumns / 2) / @resolution
    i = (row - @numberOfRows / 2) / @resolution
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
    @drawFractal()
  
  changeType: ->
    @type = document.getElementById("type").value
    console.log "type", @type
    @drawFractal()

window.Fractal = Fractal
