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

unless @scripts.is_a?(Array) && @scripts.any?
  puts 'No scripts found.'
  return
end

canvas_id = Sottolio::get 'game'
go_next   = Sottolio::get 'next'
canvas    = Canvas.new canvas_id

database  = Database.new
script    = Script.new @scripts
script.reverse!

block  = Block.new
config = {
  :canvas_id   => 'game',
  :font_family => 'Arial',
  :font_size   => '30px',
  :font_color  => '#000'
}
canvas_text   = CanvasText.new   canvas_id, config
canvas_button = CanvasButton.new canvas_id, config, block

sound_manager = SoundManager.new
image_manager = ImageManager.new
input         = nil

next_dialogue = -> {
  if block.free? && (!input || input.destroyed? || (input.alive? && input.fill?)) && script.any?
    input.save_and_destroy! if input.is_a?(CanvasInput) && input.alive?
    canvas.fill_style = '#fff'

    current = script.pop
    case current.keys.first
      when :play_sound
        return next_dialogue.call unless current[:play_sound].true? database
        sound_manager.add  current[:play_sound][:id], Sound.new(current[:play_sound][:resource], current[:play_sound][:loop], current[:play_sound][:volume])
        sound_manager.play current[:play_sound][:id]
        next_dialogue.call
      when :stop_sound
        return next_dialogue.call unless current[:stop_sound].true? database
        sound_manager.stop current[:stop_sound][:id]
        next_dialogue.call
      when :background
        return next_dialogue.call unless current[:background].true? database
        image_manager.add  Background.new(canvas_id, current[:background][:resource], current[:background][:id])
        image_manager.draw current[:background][:id]
        next_dialogue.call
      when :character
        return next_dialogue.call unless current[:character].true? database
        image_manager.add  Character.new(canvas_id,  current[:character][:resource], current[:character][:id])
        image_manager.draw current[:character][:id], current[:character][:x],        current[:character][:y]
        next_dialogue.call
      when :remove
        image_manager.remove current[:remove][:id], current[:remove][:animation], current[:remove][:to], current[:remove][:speed]
        next_dialogue.call
      when :dialogue
        return next_dialogue.call unless current[:dialogue].true? database
        canvas.clear
        if current[:dialogue].include? :name
          canvas_text.write "#{current[:dialogue][:name].apply(database)}: #{current[:dialogue][:text].apply(database)}"
        else
          canvas_text.write current[:dialogue][:text].apply(database)
        end
      when :input
        return next_dialogue.call unless current[:input].true? database
        canvas.clear
        if current[:input].include? :name
          canvas_text.write "#{current[:input][:name].apply(database)}: #{current[:input][:text].apply(database)}"
        else
          canvas_text.write current[:input][:text].apply(database)
        end
        input = CanvasInput.new canvas_id, database, current[:input][:id], current[:input][:request].apply(database)
      when :choice
        return next_dialogue.call unless current[:choice].true? database
        canvas.clear
        if current[:choice].include? :name
          canvas_text.write "#{current[:choice][:name].apply(database)}: #{current[:choice][:text].apply(database)}"
        else
          canvas_text.write current[:choice][:text].apply(database)
        end
        canvas_button.get_choice database, current[:choice][:options], current[:choice][:id], next_dialogue
    end
  end
}

next_dialogue.call
Sottolio::add_listener :click, go_next, next_dialogue