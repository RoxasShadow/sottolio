require 'opal'
require './utils'
require './canvas'
require './canvasinput'
require './canvastext'
require './sottolio'

canvas_id = Sottolio::get('game')
canvas   = Canvas.new canvas_id
canvas.fill_style = '#fff'
go_next   = Sottolio::get 'next'
dialogues = []
database  = Sottolio::Database.new

canvas_text = CanvasText.new canvas_id, '2d', {
  :canvas_id   => 'game',
  :font_family => 'Arial',
  :font_size   => '30px',
  :font_color  => '#000'
}

res = [
  {
    id: Sottolio::get('city_background'),
     x: 0,
     y: 0
  },

  {
    id: Sottolio::get('girl1_character'),
     x: 800,
     y: 120
  },

  {
    id: Sottolio::get('girl2_character'),
     x: 10,
     y: 120
  }
]

canvas.draw res

dialogues << 'Hi!'
dialogues << {
  :text => 'My name is Ambrogia, and yours?',
  :fun  =>  -> { CanvasInput.new canvas_id, database, 'name', 'Your name' }
}
dialogues << 'Oh, hai #name#!'
dialogues << {
  :text     => 'How do you feel?',
  :options  =>  -> {
    choice = [
      { text: 'Good', id: 'good' },
      { text: 'Bad',  id: 'bad'  }
    ]
    canvas_text.get_choice database, choice, 'feel'
  }
}
dialogues << 'Oh, #feel#!'

dialogues.reverse!

next_dialogue = -> {
  if dialogues.any?
    canvas.clear

    dialogue = dialogues.pop
    case dialogue
      when Hash
        canvas_text.write dialogue[:text]
        dialogue.each { |k, v|
          v.call if v.is_a? Proc
        }
      when String
        pattern = /\#(.+)\#/
        r = '' # #tap doesn't seem to work here
        dialogue.split(pattern).each { |s|
          r += (database.has?(s) ? database.get(s) : s)
        }
        canvas_text.write r
    end
  end
}

next_dialogue.call

Sottolio::add_listener :click, go_next, next_dialogue

# TODO:
# - DSL
# - Hide choice button and go next after the click
# - Hide textbox after the input