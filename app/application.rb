require 'opal'
require './sottolio'
require './utils'

require './dsl'
require './script/script'

require './canvas'
require './lib/canvasinput'
require './lib/canvastext'

canvas_id = Sottolio::get 'game'
canvas    = Canvas.new canvas_id
canvas.fill_style = '#fff'
go_next   = Sottolio::get 'next'

script    = Script.new(@scripts).get_all.reverse
database  = Sottolio::Database.new

canvas_text = CanvasText.new canvas_id, '2d', {
  :canvas_id   => 'game',
  :font_family => 'Arial',
  :font_size   => '30px',
  :font_color  => '#000'
}

characters = []
input      = nil

next_dialogue = -> {
  if (!input || input.destroyed? || (input.alive? && input.fill?)) && script.any?
    input.save_and_destroy! if input.is_a?(CanvasInput) && input.alive?
    canvas.fill_style = '#fff' # CanvasInput rewrites it
    dialogue = script.pop

    case dialogue.keys.first
      when :playSound
        # TODO
        next_dialogue.call
      when :stopSound
        # TODO
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
        canvas_text.get_choice database, dialogue[:choice][:options], dialogue[:choice][:id], next_dialogue
    end
  end
}

next_dialogue.call
Sottolio::add_listener :click, go_next, next_dialogue

# TODO:
# - Disable #next_dialogue when choice buttons are visible and then hide them