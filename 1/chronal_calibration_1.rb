frequency = 0
File.readlines('input.txt').each do |line|
  positive = line[0] == '+'
  change = line[1..-1].to_i
  frequency += positive ? change : -change
end

puts frequency
