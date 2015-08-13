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
  class CanvasButton < CanvasText
    def initialize(element, hash = nil, lock = nil)
      super element, hash

      @lock = lock || ::Lock.new
    end

    def get_choice(database, options, key, on_success)
      @lock.lock!

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

        Sottolio.add_listener :click, @canvas_id, -> (e) {
          x = `e.pageX` - `#@canvas_id.offsetLeft`
          y = `e.pageY` - `#@canvas_id.offsetTop`

          if collides? r, x, y
            database.add key, options[i][:id]

            rect.each { |tr|
              clear_rect tr[:x] - 10,
                         tr[:y] - 10,
                         tr[:w] + 20,
                         tr[:h] + 15
            }

            @lock.free!

            on_success.call
          end
        }
      }
    end
  end
end
