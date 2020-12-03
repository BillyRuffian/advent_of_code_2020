Struct.new('Policy', :min, :max, :letter)
pattern = /^(\d+)-(\d+) (\w): (\w+)$/

values = File.readlines('input.txt').map do |line|
  min, max, letter, str = pattern.match(line).captures  
  [Struct::Policy.new(min.to_i, max.to_i, letter), str]
end

# Part 1

part1 = values.filter do |policy, str|
  count = str.chars.filter{ _1 == policy.letter }.count 
  count >= policy.min && count <= policy.max
end

puts part1.count

# Part 2

part2 = values.filter do |policy, str|
  values = [str.chars[policy.min-1], str.chars[policy.max-1]].uniq
  values.include?(policy.letter) && values.count == 2
end

puts part2.count

