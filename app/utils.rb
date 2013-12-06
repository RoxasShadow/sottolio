class Array
  def to_js
    [].tap { |s| each { |a| s << "#{a}, " } }.join[0..-3]
  end

  def to_s
    self.inspect
  end
end

class Hash
  def to_js
    ['{ '].tap { |s| keys.each_with_index { |k, i| s << "#{keys[i]}: '#{values[i]}', " } }.join[0..-3] + ' }'
  end

  def to_s
    self.inspect
  end
end

class String
  def apply(database, pattern = /\#(.+)\#/)
    r = ''
    self.split(pattern).each { |s|
      r += (database.has?(s) ? database.get(s) : s)
    }
    return r
  end
end