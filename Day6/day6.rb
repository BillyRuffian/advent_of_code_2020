# Part 1

puts 'Part 1'

pp File
     .read('input.txt')
     .split("\n\n")
     .map { _1.gsub("\n" ,'') }
     .map { _1.chars.uniq }
     .flatten
     .count

# Part 2

puts 'Part 2'

pp File
     .read('input.txt')
     .split("\n\n")
     .map { _1.split("\n") }
     .map { |x| x.inject(x.first.chars) { |set,v| set = set.intersection(v.chars) } }
     .map { _1.count }
     .sum