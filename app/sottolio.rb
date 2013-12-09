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
module Sottolio

  class Database
    attr_accessor :db

    def initialize
      @db = {}
    end

    def add(key, value)
      @db[key] = value
    end

    def delete(key)
      @db.delete key
    end

    def delete_if(key, &block)
      @db.delete_if key, &block
    end

    def get(key)
      @db[key]
    end

    def has?(key)
      @db.include? key
    end
      alias_method :exist?,   :has?
      alias_method :exists?,  :has?
      alias_method :include?, :has?
  end

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

  def Sottolio.get(id)
    `document.getElementById(id)`
  end

  def Sottolio.add_listener(event, element, callback)
    `element.addEventListener(event, callback, false)`
  end

end