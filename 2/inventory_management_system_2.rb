require 'damerau-levenshtein'

def find_diff_of_one(words)
  a = words[0]
  remaining_words = words[1..-1]
  remaining_words.each do |b|
    return [a, b] if DamerauLevenshtein.distance(a, b) == 1
  end
  find_diff_of_one(remaining_words)
end

a, b = find_diff_of_one(File.readlines('input.txt')).map{ |match| match.split('') }
a.each_with_index do |char, i|
  next if b[i] == char
  b.delete_at(i)
  break
end
puts "Part 2: #{b.join}"
