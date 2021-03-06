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
  module Animations
    def slide(before, after, opts)
      move = -> {
        to, speed = opts[:to], opts[:speed]

        unless out?
          @x = @x + ((to == :left ? -1 : 1) * speed)
          draw @x, @y, true
          before.call
        else
          after.call
        end
      }

      `setInterval(move, 1)`
    end

    def fade_in(draw, _, opts)
      speed     = opts[:speed] || 100
      recursion = -> { fade_in(draw, _, opts) }

      %x{
        if(typeof #@image.alpha === 'undefined') {
          #@image.alpha = 0;
        }

        #@canvas.globalAlpha = #@image.alpha / 100;
        draw.call();

        #@canvas.globalAlpha = 1.00;

        ++#@image.alpha;

        setInterval(function() {
          if(#@image.alpha <= 100)
            recursion.call();
        }, speed);
      }
    end
  end
end
