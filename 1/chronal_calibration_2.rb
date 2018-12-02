first_repeat = nil
frequency = 0
frequencies = [0]

while first_repeat.nil?
  File.readlines('input.txt').each do |line|
    positive = line[0] == '+'
    change = line[1..-1].to_i
    frequency += positive ? change : -change
    if frequencies.include? frequency
      first_repeat = frequency
      break
    end
    frequencies << frequency
  end
end

puts "First repeat is #{first_repeat}"
