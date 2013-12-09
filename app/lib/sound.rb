class Sound
  attr_accessor :sound

  def initialize(sounds, loop = false, volume = 0.5, on_end = -> {})
    @sound = %x{
      new Howl({
        urls:     #{[sounds].flatten},
        autoplay: false,
        loop:     loop,
        volume:   volume,
        onend:    on_end
      })
    }
  end

  def play
    `#@sound.play()`
  end

  def pause
    `#@sound.pause()`
  end

  def stop
    `#@sound.stop()`
  end

  def mute
    `#@sound.mute()`
  end

  def unmute
    `#@sound.unmute()`
  end
end