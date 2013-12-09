#--
# Copyright(C) 2013 Giovanni Capuano <webmaster@giovannicapuano.net>
#
# This file is part of sottolio.
#
# Botémon is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Botémon is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Botémon.  If not, see <http://www.gnu.org/licenses/>.
#++
class CanvasInput
  attr_accessor :canvas_input, :database, :key, :destroyed

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
      #@canvas_input.focus();
    }
  end

  def get
    `#@canvas_input.value`
  end

  def fill?
    `#@canvas_input.value.length > 0`
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

  def alive?
    !@destroy
  end

  def destroyed?
    @destroy
  end

  def save_and_destroy!
    @database.add @key, get
    destroy
    nil
  end
end