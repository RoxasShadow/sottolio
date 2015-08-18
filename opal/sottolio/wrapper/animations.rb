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
