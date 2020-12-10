values = File.readlines('input.txt').map(&:chomp).map(&:to_i)

# Part 1
puts 'Part 1'

inputs = values.clone.sort
joltage = 0
adapters = [0]
while !inputs.empty? do
  idx = inputs.find_index { (joltage+1..joltage+3).include?(_1) }
  adapters << inputs.delete_at(idx)
  joltage = adapters.last
end
adapters << adapters.last + 3

diffs = []
adapters.each_cons(2) { |a,b| diffs << b - a }
tally = diffs.tally
pp tally
puts tally[1] * tally[3]

# Part 2
puts 'Part 2'

chunk = []
chunks = [] << chunk

(0...adapters.count).each do |i|
  chunk << adapters[i]
  if adapters[i+1] == chunk.last + 3
    chunk = []
    chunks << chunk
  end
end

# pp chunks

def combine(chunk, joltage, idx = 1, max = chunk.last + 3)
  if idx == chunk.count
    return 1 if max - joltage <= 3
    return 0
  end

  return 0 if chunk[idx] - joltage > 3

  total = 0
  total += combine(chunk, chunk[idx], idx + 1, max)
  total += combine(chunk, joltage, idx + 1, max)

  total
end

combos = chunks.map do |chunk|
  combine(chunk, chunk.first)
end

pp combos.inject(&:*)