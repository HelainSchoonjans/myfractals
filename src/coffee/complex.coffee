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

window.Complex = Complex
