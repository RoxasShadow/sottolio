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
  class ImageManager
    def initialize
      @images = {}
      @lock   = Lock.new
    end

    def add(image)
      @images[image.id.to_sym] = image
    end

    def remove(id, animation, opts)
      redraw = -> { @images.each_value &:draw }
      delete = -> { @images.delete id.to_sym; @images.each_value &:draw }

      if animations.include?(animation)
        @images[id.to_sym].send animation, redraw, delete, opts
      else
        delete.call
      end
    end

    def draw(id, x, y, animation, opts)
      image  = @images[id.to_sym]
      render = -> { image.draw x, y, x && y }

      when_available image do
        if animations.include? animation
          image.send animation, render, nil, opts
        else
          render.call
        end
      end
    end

    private
    def animations
      @animations ||= Animations.public_instance_methods
    end

    def when_available(image, &block)
      # We need to load images by keeping given priority
      # (i.e. bg must loaded first so characters will appear on top).
      @lock.on_free do
        p "#{image.id} queued"
        @lock.lock!

        image.on_load do
          p "#{image.id} loaded"
          @lock.free!

          block.call
        end
      end
    end
  end
end
