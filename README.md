Sottolio - È sopraffino
========================
Porting of [Sottaceto](https://github.com/RoxasShadow/Sottaceto) in JavaScript written in Ruby thanks to Opal.

Just like Sottaceto, sottolio is a game engine to create visual novels with ease. These games run everywhere, you only need a~~~n internet browser which supports JavaScript and HTML5~~~ decent internet browser.

The scripts (check `compiler/scripts`) are pretty self-explanatory (even more than Sottaceto's ones, actually).

Backgrounds, musics, and other stuff are kept inside `game/resources/`.

Setup
=====
`$ gem install sottolio`

`$ npm install -g uglify-js`

Run the demo
============
`$ sottolio example/scripts example/game/sottolio`


sottolio will generate `sottolio.js` and `sottolio.min.js` inside `example/game` that are nothing but the compiled version of the scripts inside `example/scripts`.

You're now ready to open `example/game/index.html` in your browser!

The [demo](http://www.giovannicapuano.net/sottolio/) is also available in the web, as well the [video gameplay](http://www.youtube.com/watch?v=djV_Z5OeBmg&feature=youtu.be) (it's a bit old tho).
