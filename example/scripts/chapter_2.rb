@scripts << Proc.new do
background  :id        => 'city',
            :resource  => 'resources/backgrounds/city.jpg'

character   :id        => 'Rosalinda',
            :resource  => 'resources/characters/rosalinda.png',
            :x         => 500,
            :y         => 120

dialogue    :name      => 'Rosalinda',
            :text      => 'Hey #name#! Did you enjoy this demo?'

dialogue    :name      => 'Rosalinda',
            :text      => 'Discover all myself at https://github.com/RoxasShadow/sottolio!'

dialogue    :name      => 'Rosalinda',
            :text      => 'Bye-chee!'

remove      :id        => 'Rosalinda',
            :animation => :slide,                               # apply a slide animation to the left
            :to        => :left,
            :speed     => 1.7
end
