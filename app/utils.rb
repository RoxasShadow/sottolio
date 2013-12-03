class Array
  def to_js
    [].tap { |s| each { |a| s << "#{a}, " } }.join[0..-3]
  end
end

class Hash
  def to_js
    ['{ '].tap { |s| keys.each_with_index { |k, i| s << "#{keys[i]}: '#{values[i]}', " } }.join[0..-3] + ' }'
  end
end