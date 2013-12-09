class SoundManager
  attr_accessor :sounds

  def initialize
    @sounds = {}
  end

  def add(id, sound)
    @sounds[id.to_sym] = sound
  end

  def remove(id)
    stop id
    @sounds.delete id
  end

  def play(id)
    @sounds[id.to_sym].play
  end

  def pause(id)
    @sounds[id.to_sym].pause
  end

  def stop(id)
    @sounds[id.to_sym].stop
  end

  def mute(id)
    @sounds[id.to_sym].mute
  end

  def unmute(id)
    @sounds[id.to_sym].unmute
  end
end