Sottolio - È sopraffino
========================

Preamble
========

Porting of [Sottaceto](https://github.com/RoxasShadow/Sottaceto) in javascript written in ruby with opal.

Just like Sottaceto, sottolio is a game engine to make in a simple way visual novels for andr—your internet browser. The games written with sottolio can run everywhere. You need only internet browsers which support javascript, HTML5 and the canvas object.

The script (you can find it in `compiler/script`) is are very self-explanatories, even more than Android's XML.
Backgrounds, musics and the other stuff are splitted in the respective folders in `game/resources/`.

Example
========

```
$ cd compiler
$ bundle install
$ rake build
$ cd ../game
```

You should be able to run `index.html` in your favorite web browser.

The [demo](http://www.giovannicapuano.net/sottolio/) is available too.