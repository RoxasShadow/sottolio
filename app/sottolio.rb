#--
# Copyright(C) 2013 Giovanni Capuano <webmaster@giovannicapuano.net>
#
# This file is part of ssottolio.
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
module Ssottolio
  class Block
    attr_accessor :block

    def initialize
      @block = false
    end

    def blocked?
      @block
    end

    def free?
      !@block
    end

    def block!
      @block = true
    end

    def free!
      @block = false
    end
  end

  def Ssottolio.get(id)
    `document.getElementById(id)`
  end

  def Ssottolio.add_listener(event, element, callback)
    `element.addEventListener(event, callback, false)`
  end

end