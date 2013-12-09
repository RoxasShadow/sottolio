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
class SoundManager
  attr_accessor :sounds

  def initialize
    @sounds = {}
  end

  def add(id, sound)
    @sounds[id.to_sym] = sound
  end

  def remove(id)
    stop id
    @sounds.delete id
  end

  def play(id)
    @sounds[id.to_sym].play
  end

  def pause(id)
    @sounds[id.to_sym].pause
  end

  def stop(id)
    @sounds[id.to_sym].stop
  end

  def mute(id)
    @sounds[id.to_sym].mute
  end

  def unmute(id)
    @sounds[id.to_sym].unmute
  end
end