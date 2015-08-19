#--
# Copyright(C) 2013-2015 Giovanni Capuano <webmaster@giovannicapuano.net>
#
# This file is part of sottolio.
#
# sottolio is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# sottolio is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with sottolio.  If not, see <http://www.gnu.org/licenses/>.
#++
module Sottolio
  class Image < Canvas
    include Animations

    attr_accessor :id

    def initialize(element, image, id, x = 0, y = 0)
      super element

      @image     = `new Image()`
      @image_src = image

      @id = id
      @x  = x
      @y  = y
    end

    def on_load(callback)
      `#@image.onload = callback;`
      `#@image.src    = #@image_src;`
    end

    def draw_image(*args)
      image, x, y = args
      `#@canvas.drawImage(image, x, y)`
    end

    def draw(x = nil, y = nil, save = false)
      draw_image @image, x || @x, y || @y

      @width  = `#@image.width`
      @height = `#@image.height`

      @x, @y = x, y if save
    end

    def out?
      position = @width + @x
      position < 0 || position > 1276
    end
  end
end
