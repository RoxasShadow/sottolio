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
    def initialize(canvas_id, database, key, placeholder, constraint, on_submit)
      @database    = database
      @key         = key
      @constraint  = constraint

      @canvas_error = CanvasError.new
      @canvas_input = `$('<input>')`
      build_and_mount placeholder, on_submit
    end

    def focus!
      `#@canvas_input.focus()`
    end

    def value
      `#@canvas_input.val()`
    end

    def empty?
      value.empty?
    end

    def save
      @database.add @key, value
    end

    def destroy
      `#@canvas_input.remove()`
      @canvas_input = nil

      @canvas_error.destroy
      @canvas_error = nil
    end

    def valid?
      Utils.acceptable_constraint? @constraint
    end

    def present?
      `#@canvas_input != nil`
    end

    def destroyed?
      not present?
    end

    def save_and_destroy
      save && destroy
    end

    def fail!(error)
      @canvas_error.error = error
      focus!
    end

    private
    def build_and_mount(placeholder, on_submit)
      `#@canvas_input.attr('type', 'text')`
      `#@canvas_input.attr('placeholder', placeholder)`
      `#@canvas_input.on('keypress', function(e) {
        if(e.which == 13) {
          on_submit.call();
        }
      })`
      `$('body').append(#@canvas_input)`
    end
  end
end
