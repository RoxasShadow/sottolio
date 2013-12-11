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
class String
  def apply(database, pattern = /\#(.+)\#/)
    r = ''
    self.split(pattern).each { |s|
      r += (database.has?(s) ? database.get(s) : s)
    }
    r
  end

  def filename
    self.split('/').last
  end

  def to_regex
    self.start_with?(?/) && self.end_with?(?/) ? /#{self[1..-2]}/ : self
  end
end