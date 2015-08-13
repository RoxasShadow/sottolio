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
  class Sound
    attr_accessor :sound

    def initialize(sounds, loop = false, volume = 0.5, on_end = -> {})
      @sound = %x{
        new Howl({
          urls:     #{[sounds].flatten},
          autoplay: false,
          loop:     loop,
          volume:   volume,
          onend:    on_end,
          buffer:   true
        })
      }
    end

    def play
      `#@sound.play()`
    end

    def pause
      `#@sound.pause()`
    end

    def stop
      `#@sound.stop()`
    end

    def mute
      `#@sound.mute()`
    end

    def unmute
      `#@sound.unmute()`
    end
  end
end
