values = File.readlines('input.txt').map(&:chomp).map(&:chars)


# Part 1
puts 'Part 1'
x_cycle = (0..values.first.length-1).cycle
x = x_cycle.next
x_inc = 3

hits_and_misses = values.map do |line|
  hit_or_miss = line[x]
  x_inc.times { x = x_cycle.next }
  hit_or_miss == '#' ? 1 : 0
end

puts hits_and_misses.sum

# Part 2
puts 'Part 2'
paths = [
  [1,1],
  [3,1],
  [5,1],
  [7,1],
  [1,2]
]

results = paths.map do |right, down|
  x_cycle = (0..values.first.length-1).cycle
  x = x_cycle.next
  y_cycle = (1..down).cycle
  y = y_cycle.next

  hits_and_misses = values.map do |line|
    hit_or_miss = line[x]
    y = y_cycle.next
    next if y != down
    right.times { x = x_cycle.next }
    hit_or_miss == '#' ? 1 : 0
  end
  hits_and_misses.compact.sum
end

results.each { puts _1 }
puts results.inject(:*)