Sottolio - È sopraffino
========================

Preamble
========

Porting of [Sottaceto](https://github.com/RoxasShadow/Sottaceto) in javascript written in ruby with opal.

Just like Sottaceto, sottolio is a game engine to make in a simple way visual novels for andr—your internet browser. Games written with sottolio run everywhere, you only need an internet browser which supports javascript and HTML5.

The script (you can find it in `compiler/script`) is very self-explanatory, even more than Android's XML.
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

The [demo](http://www.giovannicapuano.net/sottolio/) is available. As well the [video](http://www.youtube.com/watch?v=djV_Z5OeBmg&feature=youtu.be) too.
