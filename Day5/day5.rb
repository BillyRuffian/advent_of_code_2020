# Part 1

# It's binary encoding - the whole '* 8' thing is a 2^3 = 8 so lshift the
# row digits by 3 and append the col encoding.
# Consider the seat number 
#   B   F   F   F   B   B   F   R   R   R - the seat number 
# 512 256 128  64  32  16   8   4   2   1 
# if B and R map to 1, L and F map to 0...
#   1   0   0   0   1   1   0   1   1   1
# 1000110111 base 2 = 567 base 10

puts 'Part 1'
seat_numbers = File
                 .readlines('input.txt')
                 .map(&:chomp)
                 .map { |val| val.chars.map { |x| {'F' => 0, 'B' => 1, 'L' => 0, 'R' => 1 }[x] }
                 .join
                 .to_i(2) }

puts seat_numbers.max

# Part 2

puts 'Part 2'

puts (seat_numbers.min..seat_numbers.max).to_a - seat_numbers.sort