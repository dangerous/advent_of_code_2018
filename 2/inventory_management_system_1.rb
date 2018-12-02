twos = 0
threes = 0

input = File.readlines('input.txt').map(&:freeze)

input.each do |line|
  counts = Hash[line.split('').group_by { |c| c }.map { |k, v| [k, v.size] }].values
  twos += 1 if counts.include?(2)
  threes += 1 if counts.include?(3)
end

puts "Part 1: #{twos * threes}"
