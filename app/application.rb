require 'opal'
require './sottolio'
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

script    = Script.new(@scripts).get_all.reverse
database  = Sottolio::Database.new

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

next_dialogue = -> {
  if block.free? && (!input || input.destroyed? || (input.alive? && input.fill?)) && script.any?
    input.save_and_destroy! if input.is_a?(CanvasInput) && input.alive?
    canvas.fill_style = '#fff'

    current = script.pop
    case current.keys.first
      when :play_sound
        sound_manager.add  current[:play_sound][:id], Sound.new(current[:play_sound][:resource], current[:play_sound][:loop], current[:play_sound][:volume])
        sound_manager.play current[:play_sound][:id]
        next_dialogue.call
      when :stop_sound
        sound_manager.stop current[:stop_sound][:id]
        next_dialogue.call
      when :background
        background = Image.new canvas_id, current[:background][:resource], current[:background][:resource].filename, 'asset'
        background.save
        background.draw 0, 0
        images << background
        next_dialogue.call
      when :character
        character = Image.new canvas_id, current[:character][:resource], current[:character][:resource].filename, 'asset'
        character.save
        character.draw current[:character][:x], current[:character][:y]
        images << character
        next_dialogue.call
      when :dialogue
        canvas.clear
        if current[:dialogue].include? :name
          canvas_text.write "#{current[:dialogue][:name].apply(database)}: #{current[:dialogue][:text].apply(database)}"
        else
          canvas_text.write current[:dialogue][:text].apply(database)
        end
      when :input
        canvas.clear
        if current[:input].include? :name
          canvas_text.write "#{current[:input][:name].apply(database)}: #{current[:input][:text].apply(database)}"
        else
          canvas_text.write current[:input][:text].apply(database)
        end
        input = CanvasInput.new canvas_id, database, current[:input][:id], current[:input][:request].apply(database)
      when :choice
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