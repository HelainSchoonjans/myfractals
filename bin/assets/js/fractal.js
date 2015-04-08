// Generated by CoffeeScript 1.9.1
(function() {
  var Complex, Fractal;

  Complex = (function() {
    function Complex(r, i) {
      this.r = r != null ? r : 0;
      this.i = i != null ? i : 0;
      this.magnitude = this.r * this.r + this.i * this.i;
    }

    Complex.prototype.plus = function(c2) {
      return new Complex(this.r + c2.r, this.i + c2.i);
    };

    Complex.prototype.times = function(c2) {
      return new Complex(this.r * c2.r - this.i * c2.i, this.r * c2.i + this.i * c2.r);
    };

    Complex.prototype.negation = function() {
      return new Complex(-1 * this.r, -1 * this.i);
    };

    Complex.prototype.inverse = function() {
      if (this.magnitude === 0) {
        throw Error("no inverse");
      }
      return new Complex(this.r / this.magnitude, -1 * this.i / this.magnitude);
    };

    Complex.prototype.toString = function() {
      if (this.i === 0) {
        return "" + this.r;
      }
      if (this.r === 0) {
        return this.i + "i";
      }
      if (this.i > 0) {
        return this.r + " + " + this.i + "i";
      } else {
        return this.r + " - " + (-1 * this.i) + "i";
      }
    };

    return Complex;

  })();

  Fractal = (function() {
    Fractal.prototype.numberOfRows = 1000;

    Fractal.prototype.numberOfColumns = 1000;

    Fractal.prototype.canvas = null;

    Fractal.prototype.drawingContext = null;

    Fractal.prototype.epsilon = 0.0001;

    Fractal.prototype.maxIterations = 25;

    Fractal.prototype.cellSize = 1;

    function Fractal() {
      this.createCanvas();
      this.resizeCanvas();
      this.createDrawingContext();
      this.drawMandelbrot();
    }

    Fractal.prototype.createCanvas = function() {
      this.canvas = document.createElement('canvas');
      return document.body.appendChild(this.canvas);
    };

    Fractal.prototype.resizeCanvas = function() {
      this.canvas.height = this.cellSize * this.numberOfRows;
      return this.canvas.width = this.cellSize * this.numberOfColumns;
    };

    Fractal.prototype.createDrawingContext = function() {
      return this.drawingContext = this.canvas.getContext('2d');
    };

    Fractal.prototype.drawMandelbrot = function() {
      var column, i, ref, results, row;
      results = [];
      for (row = i = 0, ref = this.numberOfRows; 0 <= ref ? i < ref : i > ref; row = 0 <= ref ? ++i : --i) {
        results.push((function() {
          var j, ref1, results1;
          results1 = [];
          for (column = j = 0, ref1 = this.numberOfColumns; 0 <= ref1 ? j < ref1 : j > ref1; column = 0 <= ref1 ? ++j : --j) {
            results1.push(this.drawCurrentPixel(row, column));
          }
          return results1;
        }).call(this));
      }
      return results;
    };

    Fractal.prototype.drawCurrentPixel = function(row, column) {
      var b, c, iteration, z;
      iteration = 0;
      c = new Complex(row * 2 / 300 - 3, column * 2 / 300 - 3);
      z = new Complex(0, 0);
      while (iteration < this.maxIterations && z.magnitude < 2) {
        z = z.times(z).plus(c);
        iteration = iteration + 1;
      }
      b = iteration * 360 / this.maxIterations;
      this.drawingContext.fillStyle = "hsl(" + b + ", 60%, 50%)";
      return this.drawingContext.fillRect(row * this.cellSize, column * this.cellSize, this.cellSize, this.cellSize);
    };

    return Fractal;

  })();

  window.Fractal = Fractal;

}).call(this);
