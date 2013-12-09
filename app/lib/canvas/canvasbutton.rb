class CanvasButton < CanvasText
  attr_accessor :block

  def initialize(element, hash = nil, block = nil)
    super element, hash
    @block = block || Sottolio::Block.new
  end

  def get_choice(database, options, key, on_success)
    @block.block!
    fill_style = 'rgba(200, 54, 54, 0.5)'

    rect = [
      { x: 250, y: 790, w: 300, h: 50, tx: 260, ty: 825 },
      { x: 750, y: 790, w: 300, h: 50, tx: 760, ty: 825 }
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
          rect.each { |tr| clear_rect tr[:x] - 10, tr[:y] - 10, tr[:w] + 20, tr[:h] + 15 }
          @block.free!

          on_success.call
        end
      }
    }
  end
end