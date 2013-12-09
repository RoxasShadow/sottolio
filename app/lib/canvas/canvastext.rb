class CanvasText < Canvas
  attr_accessor :canvas_text

  def initialize(element, hash = nil)
    super element, '2d'

    @canvas_id = element
    %x{
      #@canvas_text = new CanvasText;
    }

    config hash if hash
  end

  def config(hash)
    %x{
      #@canvas_text.config({
        canvasId   : #{hash[:canvas_id]},
        fontFamily : #{hash[:font_family]},
        fontSize   : #{hash[:font_size]},
        fontColor  : #{hash[:font_color]}
      });
    }
  end

  def draw_text(hash)
    %x{
      #@canvas_text.drawText({
        x        : #{hash[:x]},
        y        : #{hash[:y]},
        text     : #{hash[:text]},
        boxWidth : #{hash[:box_width] || '130px'}
      });
    }
  end

  def write(what, keep = false)
    draw_text({
      :x         => 5,
      :y         => 760,
      :text      => what,
      :box_width => '130px'
    })
  end
end