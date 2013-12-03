class CanvasInput
  attr_accessor :canvas_input, :value

  def initialize(id, database, key, text, x = 10, y = 800)
    %x{
      #@canvas_input = new CanvasInput({
        canvas: id,
        x: x,
        y: y,
        placeHolder: text,
        fontSize: 18,
        fontFamily: 'Arial',
        fontColor: '#212121',
        fontWeight: 'bold',
        width: 300,
        padding: 8,
        borderWidth: 1,
        borderColor: '#000',
        borderRadius: 3,
        boxShadow: '1px 1px 0px #fff',
        innerShadow: '0px 0px 5px rgba(0, 0, 0, 0.5)'
      });
    }

    %x{
      #@canvas_input.onsubmit(function(a, b) {
        #@value = b.value();
        #{database.add(key, @value)}
      }).onkeyup(function(a, b) {
        #@value = b.value();
        #{database.add(key, @value)}
      }).focus();
    }
  end
end