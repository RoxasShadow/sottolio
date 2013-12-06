class CanvasInput
  attr_accessor :canvas_input, :database, :key, :destroyed

  def initialize(id, database, key, text = '', x = 10, y = 800)
    @database  = database
    @key       = key
    @destroyed = false
    
    %x{
      #@canvas_input = new CanvasText(id, {
        x: x,
        y: y,
        placeHolder: text,
        width: 300,
        padding: 8
      });
      #@canvas_input.focus();
    }
  end

  def get
    `#@canvas_input.value`
  end

  def fill?
    `#@canvas_input.value.length > 0`
  end

  def destroy
    @destroy = true
    %x{
      #@canvas_input.unfocus();
      #@canvas_input.refresh = null;
      #@canvas_input.destroy();
      delete #@canvas_input;
    }
  end

  def alive?
    !@destroy
  end

  def destroyed?
    @destroy
  end

  def save_and_destroy!
    @database.add @key, get
    destroy
    nil
  end
end