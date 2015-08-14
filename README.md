sottolio - è sopraffino
========================
Porting of [Sottaceto](https://github.com/RoxasShadow/Sottaceto) in JavaScript written in Ruby thanks to [Opal](https://github.com/opal/).

Just like Sottaceto, sottolio is a game engine to create visual novels with ease. These games run everywhere, you only need a~~n internet browser which supports JavaScript and HTML5~~ decent internet browser.

The scripts (check `example/scripts`) are pretty self-explanatory (even more than Sottaceto's ones, actually).

Backgrounds, musics, and other stuff are kept inside `example/game/resources/`.

Setup
=====
`$ gem install sottolio`

`$ npm install -g uglify-js`

Run the demo
============
`$ sottolio example/scripts example/game/sottolio`


sottolio will generate `example/game/sottolio.js` and `example/game/sottolio.min.js` that are nothing but the compiled versions of the scripts inside `example/scripts`.

You're now ready to open `example/game/index.html` in your browser!

The [demo](http://www.giovannicapuano.net/sottolio/) is also available in the web, as well the [video gameplay](http://www.youtube.com/watch?v=djV_Z5OeBmg&feature=youtu.be) (it's a bit old tho).

FAQ
===
**Q**: I can't see one or more assets (girls, images, sounds or whatever) on Chrome
*R*: This is a well known bug. Please refresh the page thrice.
