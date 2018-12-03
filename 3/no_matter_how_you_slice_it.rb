class Fabric
  attr_accessor :squares

  def initialize
    @squares = {}
    @first_run = true
  end

  def book_squares(origX, origY, w, h)
    w.times do |dx|
      h.times do |dy|
        x = origX + dx
        y = origY + dy
        @squares[[x, y]] = @squares[[x, y]].nil? ? 'O' : 'X'
      end
    end
  end

  def detect_collisions(index, origX, origY, w, h)
    collides = false
    w.times do |dx|
      h.times do |dy|
        x = origX + dx
        y = origY + dy
        collides = true if @squares[[x, y]] == 'X'
      end
    end
    puts index unless collides
  end
end

f = Fabric.new
File.readlines('input.txt').each do |line|
  origX = line.split(' ')[2].split(',')[0].to_i
  origY = line.split(' ')[2].split(',')[1].to_i
  dx = line.split(' ')[3].split('x')[0].to_i
  dy = line.split(' ')[3].split('x')[1].to_i
  f.book_squares(origX, origY, dx, dy)
end

puts f.squares.values.count('X')
File.readlines('input.txt').each do |line|
  index = line.split(' ')[0].split('#')[1].to_i
  origX = line.split(' ')[2].split(',')[0].to_i
  origY = line.split(' ')[2].split(',')[1].to_i
  dx = line.split(' ')[3].split('x')[0].to_i
  dy = line.split(' ')[3].split('x')[1].to_i
  f.detect_collisions(index, origX, origY, dx, dy)
end
