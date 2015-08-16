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
  class CanvasError
    def initialize
      @canvas_error = `$('<span>')`
      build_and_mount
    end

    def error=(message)
      `#@canvas_error.html(message)`
    end

    def destroy
      `#@canvas_error.remove()`
      @canvas_error = nil
    end

    def present?
      `#@canvas_error != nil`
    end

    def destroyed?
      not present?
    end

    private
    def build_and_mount
      `$('body').append(#@canvas_error)`
    end
  end
end
