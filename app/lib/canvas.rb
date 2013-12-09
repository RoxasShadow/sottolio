class Canvas
  attr_accessor :context, :canvas_id, :canvas

  def initialize(element, context = '2d')
    @context   = context
    @canvas_id = element
    @canvas    = `element.getContext(context)`
  end

  def fill_style=(color)
    `#@canvas.fillStyle = color`
  end

  def begin_path;    `#@canvas.beginPath()` ; end
  def close_path;    `#@canvas.closePath()` ; end
  def move_to(x, y); `#@canvas.moveTo(x, y)`; end
  def line_to(x, y); `#@canvas.lineTo(x, y)`; end
  def stroke;        `#@canvas.stroke()`    ; end
  def fill;          `#@canvas.fill()`      ; end

  def quadratic_curve_to(cpx, cpy, x, y)
    `#@canvas.quadraticCurveTo(cpx, cpy, x, y)`
  end

  def clear_rect(x, y, width, height)
    `#@canvas.clearRect(x, y, width, height)`
  end

  def round_rect(x, y, width, height, radius = 5, fill = true, stroke = true)
    begin_path
    move_to            x + radius,         y
    line_to            x + width - radius, y
    quadratic_curve_to x + width,          y,                  x + width,          y + radius
    line_to            x + width,          y + height - radius
    quadratic_curve_to x + width,          y + height,         x + width - radius, y + height
    line_to            x + radius,         y + height
    quadratic_curve_to x,                  y + height,         x,                  y + height - radius
    line_to            x,                  y + radius
    quadratic_curve_to x,                  y,                  x + radius,         y
    close_path

    self.stroke if stroke
    self.fill   if fill
  end

  def collides?(rect, x, y)
    x > rect[:x] && x < rect[:x] + rect[:w] && y > rect[:y] && y < rect[:y] + rect[:h]
  end

  def draw(ary)
    ary.each { |a|
      draw_image a[:id], a[:x], a[:y]
    }
  end

  def draw_image(*args)
    image = args.shift
    x, y, w, h = args
    `#@canvas.drawImage(image, x, y)`
  end

  def clear
    fill_style = '#000'
    round_rect 2, 725, 1276, 120
  end
end