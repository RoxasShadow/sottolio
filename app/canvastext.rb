class CanvasText < Canvas
  attr_accessor :canvas_text

  def initialize(element, context = '2d', hash = nil)
    super element, context
    @canvas_id=element
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

  def get_choice(database, options, key)
    fill_style = 'rgba(200, 54, 54, 0.5)'

    rect = [
      { x: 100, y: 619, w: 300, h: 100, tx: 110, ty: 650 },
      { x: 800, y: 619, w: 300, h: 100, tx: 810, ty: 650 }
    ]

    rect.each_with_index { |r, i|
      round_rect r[:x], r[:y], r[:w], r[:h]

      draw_text({
        :x         => r[:tx],
        :y         => r[:ty],
        :text      => options[i][:text],
        :box_width => "#{r[:w]}px"
      })

      Sottolio::add_listener :click, @canvas_id, -> (e) {
        x = `e.pageX` - `#@canvas_id.offsetLeft`
        y = `e.pageY` - `#@canvas_id.offsetTop`

        if collides? r, x, y
          database.add key, options[i][:id]
          # TODO: destroy
        end
      }
    }
  end
end