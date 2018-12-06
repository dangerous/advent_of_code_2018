require 'pry'
require 'securerandom'

coordinates = []
File.readlines('input.txt').each do |line|
  x, y = line.chomp.split(',').map(&:to_i)
  coordinates << { name: SecureRandom.uuid, x: x, y: y }
end
w = coordinates.map{|c| c[:x]}.max
h = coordinates.map{|c| c[:y]}.max
manhattan = Array.new(h + 1) { Array.new(w + 2, '.') }

elf_dominated_squares = {}
number_squares_within_safe_region = 0
manhattan.each_with_index do |column, y|
  column.each_with_index do |row, x|
    closest_elf = nil
    closest_elf_distance = w * h # large enough!
    all_coords_distance = 0
    coordinates.each do |coordinate|
      distance = (x - coordinate[:x]).abs + (y - coordinate[:y]).abs
      all_coords_distance += distance
      if distance < closest_elf_distance
        closest_elf_distance = distance
        closest_elf = coordinate[:name]
      elsif distance == closest_elf_distance && closest_elf != coordinate[:name]
        closest_elf = "."
      end
    end
    manhattan[y][x] = closest_elf
    unless closest_elf == "."
      elf_dominated_squares[closest_elf] ||= 0
      elf_dominated_squares[closest_elf] += 1
    end
    if all_coords_distance < 10000
      number_squares_within_safe_region += 1
    end
  end
end
coordinates.each do |coordinate|
  manhattan[coordinate[:y]][coordinate[:x]] = 'X'
end

manhattan.first.each do |cell|
  elf_dominated_squares[cell] = nil
end
manhattan.last.each do |cell|
  elf_dominated_squares[cell] = nil
end
manhattan.each do |row|
  elf_dominated_squares[row.first]  = nil
  elf_dominated_squares[row.last] = nil
end

puts "Part 1: #{elf_dominated_squares.delete_if { |k, v| v.nil? }.values.max}"
puts "Part 2: #{number_squares_within_safe_region}"
