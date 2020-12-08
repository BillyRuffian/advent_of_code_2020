require_relative 'cpu'

# Part 1

puts 'Part 1'

cpu = CPU.new
File
  .readlines('input.txt')
  .map(&:chomp)
  .map { _1.split(' ') }
  .map { |op, opr| [op, opr.to_i] }
  .then { cpu.load(_1) }

history = []
while !cpu.terminated? do
  acc = cpu.acc
  history << cpu.pcr
  cpu.tick
  if history.include?(cpu.pcr)
    puts "∞ loop / acc before #{acc}"
    break
  end
end

puts cpu.acc

# Part 2

puts 'Part 2'

original_program = cpu.program
loop do
  history = []
  replacement_program = original_program.clone
  # randomly flip one of the problem instructions, not very elegant
  index_of_op_to_change = replacement_program.map.with_index { |x,i| x.first == %w(jmp nop).sample ? i : nil }.compact.sample
  original_op = replacement_program[index_of_op_to_change]
  replacement_program[index_of_op_to_change] = [original_op.first == 'jmp' ? 'nop' : 'jmp', original_op.last]
  cpu.load(replacement_program)

  while !cpu.terminated? do
    acc = cpu.acc
    history << cpu.pcr
    cpu.tick
    break if history.include?(cpu.pcr)
  end

  if cpu.terminated?
    puts "Terminated with acc #{cpu.acc} changing instruction #{index_of_op_to_change} - #{original_op}"
    break
  end
end