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
  class Bootstrapper
    def initialize(scripts)
      @scripts = scripts
    end

    def run!
      canvas_id = Sottolio.get 'game'
      go_next   = Sottolio.get 'next'
      canvas    = Canvas.new canvas_id

      database  = Database.new
      scripts   = Script.new @scripts

      config = {
        canvas_id:   'game',
        font_family: 'Arial',
        font_size:   '30px',
        font_color:  '#000'
      }
      lock          = Lock.new
      canvas_text   = CanvasText.new canvas_id, config
      canvas_button = CanvasButton.new canvas_id, config, lock

      sound_manager = SoundManager.new
      image_manager = ImageManager.new
      input         = nil

      next_dialogue = -> {
        if lock.free? && (!input || input.destroyed? || (input.present? && !input.empty?)) && scripts.any?
          input.save_and_destroy if input.is_a?(CanvasInput) && input.present?

          canvas.fill_style = '#fff'

          script          = scripts.pop
          current_command = script.keys.first
          case current_command
          when :play_sound
            return next_dialogue.call unless script[:play_sound].true? database

            sound = Sound.new(script[:play_sound][:resource], script[:play_sound][:loop], script[:play_sound][:volume])
            sound_manager.add script[:play_sound][:id], sound
            sound_manager.play script[:play_sound][:id]

            next_dialogue.call
          when :stop_sound
            return next_dialogue.call unless script[:stop_sound].true? database

            sound_manager.stop script[:stop_sound][:id]

            next_dialogue.call
          when :background
            return next_dialogue.call unless script[:background].true? database

            background = Background.new(canvas_id, script[:background][:resource], script[:background][:id])
            image_manager.add background
            image_manager.draw script[:background][:id]

            next_dialogue.call
          when :character
            return next_dialogue.call unless script[:character].true? database

            character = Character.new(canvas_id, script[:character][:resource], script[:character][:id])
            image_manager.add character
            image_manager.draw script[:character][:id], script[:character][:x], script[:character][:y]

            next_dialogue.call
          when :remove
            image_manager.remove script[:remove][:id], script[:remove][:animation], script[:remove][:to], script[:remove][:speed]

            next_dialogue.call
          when :dialogue
            return next_dialogue.call unless script[:dialogue].true? database

            canvas.clear

            if script[:dialogue].include? :name
              canvas_text.write "#{script[:dialogue][:name].apply(database)}: #{script[:dialogue][:text].apply(database)}"
            else
              canvas_text.write script[:dialogue][:text].apply(database)
            end
          when :input
            return next_dialogue.call unless script[:input].true? database

            canvas.clear

            if script[:input].include? :name
              canvas_text.write "#{script[:input][:name].apply(database)}: #{script[:input][:text].apply(database)}"
            else
              canvas_text.write script[:input][:text].apply(database)
            end

            input = CanvasInput.new canvas_id, database, script[:input][:id], script[:input][:request].apply(database)
          when :choice
            return next_dialogue.call unless script[:choice].true? database

            canvas.clear

            if script[:choice].include? :name
              canvas_text.write "#{script[:choice][:name].apply(database)}: #{script[:choice][:text].apply(database)}"
            else
              canvas_text.write script[:choice][:text].apply(database)
            end

            canvas_button.get_choice database, script[:choice][:options], script[:choice][:id], next_dialogue
          end
        end
      }

      next_dialogue.call

      Sottolio.add_listener :click, go_next, next_dialogue
    end
  end
end
