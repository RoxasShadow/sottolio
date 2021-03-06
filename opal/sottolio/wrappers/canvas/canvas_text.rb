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
  class CanvasText < Canvas
    def initialize(element, hash = nil)
      super element, '2d'

      @canvas_id   = element
      @canvas_text = `new CanvasText()`

      config hash if hash
    end

    def config(hash)
      %x{
        #@canvas_text.config({
          canvasId:   #{hash[:canvas_id]},
          fontFamily: #{hash[:font_family]},
          fontSize:   #{hash[:font_size]},
          fontColor:  #{hash[:font_color]},
          lineHeight: 30
        });
      }
    end

    def draw_text(hash)
      %x{
        #@canvas_text.drawText({
          x:        #{hash[:x]},
          y:        #{hash[:y]},
          text:     #{hash[:text]},
          boxWidth: 1280
        });
      }
    end

    def write(what, keep = false)
      draw_text({
        :x    => 10,
        :y    => 760,
        :text => what
      })
    end
  end
end
