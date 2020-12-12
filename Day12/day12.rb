steps = File.readlines('input.txt').map(&:chomp).map { [_1[0], _1[1..-1].to_i] }

# Part 1
puts 'Part 1'

loc = [0,0, 90]
X = 0
Y = 1
DIR = 2

def move(location, step)
  directions = { 0 => 'N', 90 => 'E', 180 => 'S', 270 => 'W' }
  instruction = step.first
  case step
  in 'N', val
    location[Y] += val
  in 'S', val
    location[Y] -= val
  in 'E', val
    location[X] += val
  in 'W', val
    location[X] -= val
  in 'L', val
    location[DIR] = (location[DIR] - val) % 360
  in 'R', val
    location[DIR] = (location[DIR] + val) % 360
  in 'F', val
    move(location, [directions[location[DIR]], val])
  end
end 

steps.each { |s| move(loc, s) }

pp loc[0..1].map(&:abs).sum

# Part 2
puts 'Part 2'

loc = [0,0]
way = [10,1]

steps.each do |step|
  case step
  in 'N', val
    way[Y] += val
  in 'S', val
    way[Y] -= val
  in 'E', val
    way[X] += val
  in 'W', val
    way[X] -= val
  in 'L', 90
    way = [-way[Y], way[X]]
  in 'L' | 'R', 180
    way = [-way[X], -way[Y]]
  in 'L', 270
    way = [way[Y], -way[X]]
  in 'R', 90
    way = [way[Y], -way[X]]
  in 'R', 270
    way = [-way[Y], way[X]]
  in 'F', val
    loc[X] += way[X] * val
    loc[Y] += way[Y] * val
  end
end

pp loc.map(&:abs).sum
