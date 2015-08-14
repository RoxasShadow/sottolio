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
    attr_accessor :image, :id, :x, :y, :width, :height

    def initialize(element, image, id, x = 0, y = 0)
      super element

      @image = `new Image()`
      `#@image.src = image`

      @id     = id
      @x      = x
      @y      = y
    end

    def on_load(callbac)
      `#@image.onload = callbac`
    end

    def draw_image(*args)
      image = args.shift
      x, y, width, height = args
      `#@canvas.drawImage(image, x, y)`
    end

    def draw(x = nil, y = nil, save = false)
      draw_image @image, x || @x, y || @y

      @width  = `#@image.width`
      @height = `#@image.height`

      @x, @y = x, y if save
    end

    def out?
      (@width + @x) < 0 || (@x + width) > 1276
    end

    def slide(pre_callback = nil, callback = nil, to = :right, speed = 1)
      move = -> {
        unless out?
          @x = @x + ((to == :left ? -1 : 1) * speed)
          draw @x, @y, true
          pre_callback.call if pre_callback
        else
          callback.call if callback
        end
      }

      `setInterval(move, 1)`
    end
  end
end
