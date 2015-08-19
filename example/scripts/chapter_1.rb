(@scripts ||= []) << Proc.new do
background  :id          => 'city',                               # it's the placeholder for #remove
            :resource    => 'resources/backgrounds/city.jpg'

play_sound  :id          => 'background_theme',
             :resource   => 'resources/sounds/Classmate.m4a',
             :loop       => true,
             :volume     => 0.5                                   # 0.0 - 1.0

character   :id          => 'Rosalinda',
            :resource    => 'resources/characters/rosalinda.png',
            :x           => 800,
            :y           => 120,
            :animation   => :fade_in,
            :speed       => 250

character   :id          => 'Ambrogia',
            :resource    => 'resources/characters/ambrogia.png',
            :x           => 10,
            :y           => 120,
            :animation   => :fade_in,
            :speed       => 250

dialogue    :name        => 'Ambrogia',                           # optional
            :text        => 'Hi!'

input       :name        => 'Ambrogia',
            :text        => 'My name is Ambrogia, and yours?',
            :id          => 'name',                               # the variable where the input will be saved
            :placeholder => 'Your name:',
            :constraint  => '#name# =~ /^[a-zA-Z]{3,10}$/',
            :on_fail     => 'Your name must be contained in 3-10 chars.' # printed if the input won't match the constraint

dialogue    :name        => 'Ambrogia',
            :text        => 'Oh, hai #name#!',
            :if          => '#name# =~ /^[a-zA-Z]+$/'

dialogue    :name        => 'Ambrogia',
            :text        => 'Don\'t tease me >:(',
            :unless      => '#name# =~ /^[a-zA-Z]+$/'

choice      :name        => 'Ambrogia',
            :text        => 'How do you feel?',
            :id          => 'feel',
            :options     => [
                              { id: 'good', text: 'Good' },
                              { id: 'bad',  text: 'Bad'  }
                            ]

dialogue    :name        => 'Ambrogia',
            :text        => 'I\'m glad you feel good, my dear!',
            :if          => [ '#feel# == good', '#name# == Patrizio' ]

dialogue    :name        => 'Ambrogia',
            :text        => 'I\'m glad you feel good!',
            :if          => [ '#feel# == good', '#name# != Patrizio' ]

dialogue    :name        => 'Ambrogia',
            :text        => 'I\'m sorry you feel bad!',
            :if          => '#feel# == bad'

dialogue    :name        => 'Ambrogia',
            :text        => 'Ok, time to go, cya!'

remove      :id          => 'Ambrogia',
            :animation   => :fade_out,
            :speed       => 2.5

remove      :id          => 'Rosalinda'

stop_sound  :id          => 'background_theme'
end
