
values = File.readlines('input.txt').map(&:to_i)

# part 1
values.combination(2).each do |a,b|
  puts a * b if a + b == 2020
end

# part 2
values.combination(3).each do |a,b,c|
  puts a * b * c if a + b + c == 2020
end