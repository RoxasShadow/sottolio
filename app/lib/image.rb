class Image < Canvas
  attr_accessor :src, :id, :klass

  def initialize(element, src, id = '', klass = '')
    super element
    
    @src   = src
    @id    = id
    @klass = klass
  end

  def append_to_html
    %x{
      var img = document.createElement('img');
          img.id        = #@id;
          img.className = #@klass;
          img.src       = #@src;
      document.body.appendChild(img);
    }
  end
    alias_method :write, :append_to_html
    alias_method :save,  :append_to_html

  def draw(x, y)
    super [{
      id: Sottolio::get(@id),
       x: x,
       y: y
    }]
  end

end