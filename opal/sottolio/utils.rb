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
class String
  # TODO: Find a better name for this (tl;dr replace variables with real values)
  def apply(database, pattern = /\#(.+)\#/)
    r = '' # we cannot #tap because of frozen strings
    self.split(pattern).each { |s|
      r += database.has?(s) ? database.get(s) : s
    }
    r
  end

  def filename
    self.split(?/).last
  end

  def to_regex
    self.start_with?(?/) && self.end_with?(?/) ? /#{self[1..-2]}/ : self
  end
end

class Hash
  # TODO: Find a better name for this (tl;dr eval conditional keys in the script's commands)
  def true?(database)
    return true unless self.include?(:if) || self.include?(:unless)

    res = []
    sym = self.include?(:if) ? :if : :unless
    [self[sym]].flatten.each { |c| # i.e.: [ '#feel# == good', '#name# == Patrizio' ]
      statement = c.apply(database).split(/(.+)(==|!=|=~)(.+)/).delete_if { |s| s.strip.empty? }.map(&:strip)
      eval = case statement[1] # #send won't work with !=
        when '==' then statement[0] == statement[2]
        when '!=' then statement[0] != statement[2]
        when '=~' then statement[0] =~ statement[2].to_regex
      end
      res << eval # actually this is totally not safe
    }
    res << res.inject { |sum, x| sum && x }
    return sym == :if ? res.last : !res.last
  end
end
