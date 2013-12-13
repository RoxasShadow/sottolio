#--
# Copyright(C) 2013 Giovanni Capuano <webmaster@giovannicapuano.net>
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
class Image < Canvas
  attr_accessor :src, :id, :klass, :x, :y

  def initialize(element, src, id = '', klass = '', x = 0, y = 0)
    super element
    
    @src   = src
    @id    = id
    @klass = klass
    @x     = x
    @y     = y
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

  def draw(x = nil, y = nil)
    super [{
      id: Sottolio::get(@id),
       x: x || @x,
       y: y || @y
    }]
  end

end