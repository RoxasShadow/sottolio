(@scripts ||= []) << Proc.new do
background  :resource  => 'resources/backgrounds/city.jpg'      # sugar for character with coordinates set to 0

play_sound  :id        => 'background_theme',
            :resource  => 'resources/sounds/Classmate.m4a',
            :loop      => true,
            :volume    => 0.0001                                # 0.0 - 1.0

character   :resource  => 'resources/characters/rosalinda.png',
            :name      => 'Rosalinda',                          # useless, it's just a placeholder
            :x         => 800,
            :y         => 120

character   :resource  => 'resources/characters/ambrogia.png',
            :name      => 'Ambrogia',
            :x         => 10,
            :y         => 120

dialogue    :name      => 'Ambrogia',                           # optional
            :text      => 'Hi!'
            
input       :name      => 'Ambrogia',
            :text      => 'My name is Ambrogia, and yours?',
            :id        => 'name',                               # the variable where the input will be saved
            :request   => 'Your name'
            
dialogue    :name      => 'Ambrogia',
            :text      => 'Oh, hai #name#!',
            :if        => '#name# =~ /^[a-zA-Z]+$/'

dialogue    :name      => 'Ambrogia',
            :text      => 'Don\'t tease me >:(',
            :if_not    => '#name# =~ /^[a-zA-Z]+$/'

choice      :name      => 'Ambrogia',
            :text      => 'How do you feel?',
            :id        => 'feel',
            :options   => [
                            { id: 'good', text: 'Good' },
                            { id: 'bad',  text: 'Bad'  }
                          ]

dialogue    :name      => 'Ambrogia',
            :text      => 'I\'m glad you feel good, my dear!',
            :if        => [ '#feel# == good', '#name# == Patrizio' ]

dialogue    :name      => 'Ambrogia',
            :text      => 'I\'m glad you feel good!',
            :if        => [ '#feel# == good', '#name# != Patrizio' ]

dialogue    :name      => 'Ambrogia',
            :text      => 'I\'m sorry you feel bad!',
            :if        => '#feel# == bad'

stop_sound  :id        => 'background_theme'
end