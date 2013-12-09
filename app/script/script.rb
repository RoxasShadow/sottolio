(@scripts ||= []) << Proc.new do
  background      :resource  => 'city'

  playSound       :id        => 'background_theme',
                  :resource  => 'sounds/Classmate.m4a',
                  :loop      => true,
                  :volume    => 0.3

  render          :resource  => 'girl1',
                  :name      => 'Ambrogia',
                  :x         => 800,
                  :y         => 120

  render          :resource  => 'girl2',
                  :name      => 'Rosalinda',
                  :x         => 10,
                  :y         => 120

  dialogue        :name      => 'Ambrogia',
                  :text      => 'Hi!'
                  
  input           :name      => 'Ambrogia',
                  :text      => 'My name is Ambrogia, and yours?',
                  :id        => 'name',
                  :request   => 'Your name'
                  
  dialogue        :name      => 'Ambrogia',
                  :text      => 'Oh, hai #name#!'
                  
  choice          :name      => 'Ambrogia',
                  :text      => 'How do you feel?',
                  :id        => 'feel',
                  :options   => [
                                  { id: 'good', text: 'Good' },
                                  { id: 'bad',  text: 'Bad'  }
                                ]
                  
  dialogue        :name      => 'Ambrogia',
                  :text      => 'Oh, #feel#!'

  stopSound       :id        => 'background_theme'
end