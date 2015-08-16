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
require 'forwardable'

module Sottolio
  class Script
    extend Forwardable

    # TODO: Rid of unused methods
    def initialize(scripts = [])
      @var = []
      scripts.each { |p| self << p }
      @var.reverse!
    end

    def <<(obj)
      if obj.is_a?(Proc)
        instance_eval &obj
      else
        @var << obj
      end
    end

    def_delegators :@var, :pop, :any?

    # Script's commands
    def method_missing(m, *args, &block)
      if args.any?
        args = args.first if args.length == 1
        @var << { m.to_sym => args }
        instance_variable_set "@#{m}", args
      else
        instance_variable_get "@#{m}"
      end
    end
  end
end
