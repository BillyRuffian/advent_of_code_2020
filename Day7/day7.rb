bags = Hash.new{ |hash, key| hash[key] = {} }

File.readlines('input.txt').each do |line|
  colour,contents = /(\w+ \w+) bags? contain (.*)/.match(line).captures
  contents.split(', ').each do |c|
    next if c =~ /no other bags?\.?/
    num, nested_colour = /(\d+) (\w+ \w+)/.match(c).captures
    bags[colour][nested_colour] = num.to_i
  end
end

# Part 1
puts 'Part 1'

def search(bags, colour, total = [])
  containers = bags.map { |i,v| v.keys.include?(colour) ? i : nil }.compact
  containers.each { search(bags, _1, total << containers) }
  total
end

pp search(bags, 'shiny gold').flatten.uniq.count

# Part 2
puts 'Part 2'

def group(all_bags, current_bag, counters, multiplier = 1)
  all_bags[current_bag].each do |b, c|
    counters[b] ||= 0
    counters[b] += c * multiplier
    group(all_bags, b, counters, c*multiplier)
  end
end

counters = {}
group(bags, 'shiny gold', counters)
# pp counters
pp counters.values.sum
