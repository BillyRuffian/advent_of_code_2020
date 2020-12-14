instructions = File.readlines('input.txt').map(&:chomp)

# Part 1
puts 'Part 1'

memory = []
mask_on = 0
mask_off = 0

instructions.each do |ins|
  if ins.start_with? 'mask ='
    mask_data = /mask = ([01X]+)/.match(ins).captures.first
    mask_on  = mask_data.chars.map { |x| x == '1' ? '1' : '0' } .join.to_i(2)
    mask_off = mask_data.chars.map { |x| x == '0' ? '1' : '0' } .join.to_i(2)
  else
    addr, val = /mem\[(\d+)\] = (\d+)/.match(ins).captures.map(&:to_i)
    memory[addr] = ((val | mask_on) & (~mask_off))
  end
end

pp memory.compact.sum

# Part 2
puts 'Part 2'

memory = Hash.new { 0 }
floating_bits = []

instructions.each do |ins|
  if ins.start_with? 'mask ='
    mask_data = /mask = ([01X]+)/.match(ins).captures.first
    mask_on  = mask_data.chars.map { |x| x == '1' ? '1' : '0' } .join.to_i(2)
    floating_bits = mask_data.chars.reverse.map.with_index { |x, idx| idx if x == 'X' }.compact
  else
    addr, val = /mem\[(\d+)\] = (\d+)/.match(ins).captures.map(&:to_i)
    [0,1].repeated_permutation(floating_bits.count).each do |bit_perms|
      decoded_addr = addr | mask_on
      floating_bits.zip(bit_perms) do |fbit, v|
        if v == 1
          decoded_addr |= (1 << fbit)
        else
          decoded_addr &= (~(1 << fbit))
        end
      end
      memory[decoded_addr] = val
    end
  end
end

pp memory.values.sum