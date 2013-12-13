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
class ImageManager
  attr_accessor :images

  def initialize
    @images = {}
  end

  def add(image)
    @images[image.id.to_sym] = image
  end

  def remove(id)
    @images.delete id.to_sym
    @images.each_value &:draw
  end

  def append_to_html(id)
    @images[id.to_sym].save
  end
    alias_method :write, :append_to_html
    alias_method :save,  :append_to_html

  def draw(id)
    @images[id.to_sym].draw
  end
end