def react(str)
  chars = str.chomp.split('')
  loop do
    chars.each_with_index do |char, index|
      chars[(index..index + 1)] = nil if chars[index + 1] == char.swapcase
    end
    return chars.count unless chars.compact!
  end
end

input = File.read('input.txt').freeze

puts "Part 1: #{react(input)}"
puts "Part 2: #{('a'..'z').map { |letter| react(input.gsub(/#{letter}/i, '')) }.min}"
