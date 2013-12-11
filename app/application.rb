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
require 'opal'
require './sottolio'
require './database'
require './utils'

require './dsl'
require './script/script'

require './lib/canvas'
require './lib/canvas/canvasinput'
require './lib/canvas/canvastext'
require './lib/canvas/canvasbutton'

require './lib/image'
require './lib/sound'
require './soundmanager'

canvas_id = Sottolio::get 'game'
go_next   = Sottolio::get 'next'
canvas    = Canvas.new canvas_id

database  = Database.new
script    = Script.new @scripts
script.reverse!

block  = Sottolio::Block.new
config = {
  :canvas_id   => 'game',
  :font_family => 'Arial',
  :font_size   => '30px',
  :font_color  => '#000'
}
canvas_text   = CanvasText.new   canvas_id, config
canvas_button = CanvasButton.new canvas_id, config, block

sound_manager = SoundManager.new
images        = []
input         = nil

condition = -> (current) {
  return true unless current.include?(:if) || current.include?(:if_not)

  res = []
  sym = current.include?(:if) ? :if : :if_not
  [current[sym]].flatten.each { |c|
    statement = c.apply(database).split(/(.+)(==|!=|=~)(.+)/).delete_if { |s| s.strip.empty? }.map { |s| s.strip }
    eval = case statement[1] # #send won't work with !=
      when '==' then statement[0] == statement[2]
      when '!=' then statement[0] != statement[2]
      when '=~' then statement[0] =~ statement[2].to_regex
    end
    res << eval
  }
  res << res.inject { |sum, x| sum && x }
  return sym == :if ? res.last : !res.last
}

next_dialogue = -> {
  if block.free? && (!input || input.destroyed? || (input.alive? && input.fill?)) && script.any?
    input.save_and_destroy! if input.is_a?(CanvasInput) && input.alive?
    canvas.fill_style = '#fff'

    current = script.pop
    case current.keys.first
      when :play_sound
        return next_dialogue.call unless condition.call current[:play_sound]
        sound_manager.add  current[:play_sound][:id], Sound.new(current[:play_sound][:resource], current[:play_sound][:loop], current[:play_sound][:volume])
        sound_manager.play current[:play_sound][:id]
        next_dialogue.call
      when :stop_sound
        return next_dialogue.call unless condition.call current[:stop_sound]
        sound_manager.stop current[:stop_sound][:id]
        next_dialogue.call
      when :background
        return next_dialogue.call unless condition.call current[:background]
        background = Image.new canvas_id, current[:background][:resource], current[:background][:resource].filename, 'asset'
        background.save
        background.draw 0, 0
        images << background
        next_dialogue.call
      when :character
        return next_dialogue.call unless condition.call current[:character]
        character = Image.new canvas_id, current[:character][:resource], current[:character][:resource].filename, 'asset'
        character.save
        character.draw current[:character][:x], current[:character][:y]
        images << character
        next_dialogue.call
      when :dialogue
        return next_dialogue.call unless condition.call current[:dialogue]
        canvas.clear
        if current[:dialogue].include? :name
          canvas_text.write "#{current[:dialogue][:name].apply(database)}: #{current[:dialogue][:text].apply(database)}"
        else
          canvas_text.write current[:dialogue][:text].apply(database)
        end
      when :input
        return next_dialogue.call unless condition.call current[:input]
        canvas.clear
        if current[:input].include? :name
          canvas_text.write "#{current[:input][:name].apply(database)}: #{current[:input][:text].apply(database)}"
        else
          canvas_text.write current[:input][:text].apply(database)
        end
        input = CanvasInput.new canvas_id, database, current[:input][:id], current[:input][:request].apply(database)
      when :choice
        return next_dialogue.call unless condition.call current[:choice]
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

# TODO:
# - remove character