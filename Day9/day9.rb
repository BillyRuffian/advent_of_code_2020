# Part 1
puts 'Part 1'

values = File.readlines('input.txt').map(&:chomp).map(&:to_i)
preamble = 25



# values[preamble..-1].each_with_index do |v, i|
#   # pp i + preamble
#   pp [i, preamble, i+ preamble]
#   # puts v unless values[preamble..i+preamble*2].combination(2).any? { |pair| pair.sum == v }
# end

invalid = (preamble...values.count)
            .map { |i| values[i] unless values[i-preamble...i].combination(2).any? { |pair| pair.sum == values[i] } }
            .compact
            .first

pp invalid

# Part 2
puts 'Part 2'

(0...values.count).each do |i|
  sum = 0
  nums = []
  (i...values.count).each do |j|
    nums << values[j]
    if nums.sum == invalid && nums.count > 1
      pp nums.min + nums.max
      break
    end
    next if nums.sum > invalid
  end
end