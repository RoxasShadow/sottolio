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
  class CanvasInput
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
      }

      focus
    end

    def focus
      `#@canvas_input.focus();`
    end

    def value
      `#@canvas_input.value`
    end

    def empty?
      `#@canvas_input.value.length == 0`
    end

    def save
      @database.add @key, value
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

    def present?
      not destroyed?
    end

    def destroyed?
      @destroy
    end

    def save_and_destroy
      save && destroy
    end
  end
end
