# Part 1
puts 'Part 1'

earliest = nil
buses = []
File.open('input.txt', 'r') do |f|
  earliest = f.readline.to_i
  buses = f.readline.chomp.split(',').filter { _1 != 'x' }.map(&:to_i)
end

bus = nil
time = earliest
until bus do
  time += 1
  departures = buses
                .map
                .with_index { |b,i| [i, time % b] }
                .filter { |b,t| t == 0 }
                .flatten
  
  bus = buses[departures.first] if !departures.empty?
end

pp [bus, time - earliest]
pp (time - earliest) * bus

# Part 2
# The answer to Part 2 uses the Chinese Remainder Theory
# The code below will answer the problem. The chinese_remainder
# method is lifted straight from rosetta code.
# As a result, I'm not submitting my answer to AoC for the
# part.

puts 'Part 2'

def chinese_remainder(mods, remainders)
  max = mods.inject( :* )                            
  series = remainders.zip( mods ).map{|r,m| r.step( max, m ).to_a } 
  series.inject( :& ).first #returns nil when empty
end

buses = []
File.open('sample.txt', 'r') do |f|
  _ = f.readline.to_i
  buses = f.readline.chomp.split(',').map { |v| v == 'x' ? v : v.to_i  }
end

departure_offsets = []

buses.filter_map.with_index do |bus_id, index|
  departure_offsets << index * -1 unless bus_id == 'x'
end

pp departure_offsets

pp chinese_remainder(buses.reject{ _1 == 'x' }, departure_offsets)