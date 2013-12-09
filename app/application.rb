require 'opal'
require './sottolio'
require './utils'

require './dsl'
require './script/script'

require './lib/canvas'
require './lib/canvas/canvasinput'
require './lib/canvas/canvastext'
require './lib/canvas/canvasbutton'

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
canvas_text   = CanvasText.new   canvas_id, '2d', config
canvas_button = CanvasButton.new canvas_id, '2d', config, block

sound_manager = SoundManager.new

characters = []
sounds     = {}
input      = nil

next_dialogue = -> {
  if block.free? && (!input || input.destroyed? || (input.alive? && input.fill?)) && script.any?
    input.save_and_destroy! if input.is_a?(CanvasInput) && input.alive?
    canvas.fill_style = '#fff'
    dialogue = script.pop

    case dialogue.keys.first
      when :playSound
        sound_manager.add  dialogue[:playSound][:id], Sound.new(dialogue[:playSound][:resource], dialogue[:playSound][:loop], dialogue[:playSound][:volume])
        sound_manager.play dialogue[:playSound][:id]
        next_dialogue.call
      when :stopSound
        sound_manager.stop dialogue[:stopSound][:id]
        next_dialogue.call
      when :background
        canvas.draw([{
          id: Sottolio::get("#{dialogue[:background][:resource]}_background"),
           x: 0,
           y: 0
        }])
        next_dialogue.call
      when :render
        characters << dialogue[:render]
        canvas.draw([{
          id: Sottolio::get("#{dialogue[:render][:resource]}_character"),
           x: dialogue[:render][:x],
           y: dialogue[:render][:y]
        }])
        next_dialogue.call
      when :dialogue
        canvas.clear
        canvas_text.write "#{dialogue[:dialogue][:name].apply(database)}: #{dialogue[:dialogue][:text].apply(database)}"
      when :input
        canvas.clear
        canvas_text.write "#{dialogue[:input][:name].apply(database)}: #{dialogue[:input][:text].apply(database)}"
        input = CanvasInput.new canvas_id, database, dialogue[:input][:id], dialogue[:input][:request].apply(database)
      when :choice
        canvas.clear
        canvas_text.write "#{dialogue[:choice][:name].apply(database)}: #{dialogue[:choice][:text].apply(database)}"
        canvas_button.get_choice database, dialogue[:choice][:options], dialogue[:choice][:id], next_dialogue
    end
  end
}

next_dialogue.call
Sottolio::add_listener :click, go_next, next_dialogue

# TODO: Image