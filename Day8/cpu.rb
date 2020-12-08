class CPU
  attr_reader :pcr, :acc, :program

  def initialize(debug = false)
    reset
    @debug = debug
  end

  def reset
    @pcr = 0
    @acc = 0
  end

  def load(program)
    @program = program
    reset
  end

  def tick
    op, opr = @program[@pcr]
    pp [@pcr, op, opr] if @debug
    self.send("perform_#{op}", *opr)
  end

  def perform_jmp(opr)
    @pcr += opr
  end

  def perform_nop(opr)
    @pcr += 1
  end

  def perform_acc(opr)
    @acc += opr
    @pcr += 1
  end

  def terminated?
    @pcr >= @program.count
  end

end