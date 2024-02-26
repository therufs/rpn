class RpnCalculator

# Consume a series of numbers, followed by a series of operands.
# When a sufficient arity of numbers per operand is available,
# execute the operation and return the value.
# Use the returned value as the first argument.

  OPERATORS = %w(+ - / *)
  NUMBER_PATTERN = /[0-9]+/ # ruby helpfully casts anything that isn't a number to 0
  ARITY = 2

  attr_reader :next_operand

  def initialize
    @operands = []
    @operators = []
  end

  def receive_input(input = nil)
    # this is kind of a mess -- this doesn't seem like where the arg shd go
    # could make a case statement based on a flag and then readlines or readfile
    if input.nil?
      puts "awaiting input ..."
      until enough_to_work_with_on_the_stacks?
        input = readlines
        sort_input(input)
      end
    else
      sort_input(input)
    end
  end

  def sort_input(input)
    parsed_input = parse(input)
    parsed_input.each do |p|
      # this isn't very POODR :(
      if NUMBER_PATTERN.match p
        @operands << p.to_f
      elsif OPERATORS.include? p
        @operators << p.to_sym
      elsif p == 'q'
        exit
      else
        complain_politely(p)
      end
    end
  end

  def do_math
    while enough_to_work_with_on_the_stacks?; do_something_about_it; end
  end

  def enough_to_work_with_on_the_stacks?
    # will need to surface this into args if ever a non-binary operator
    ops_length = @operands.length
    @operators.any? && (ops_length >= ARITY || (@next_operand && (ops_length + 1 >= ARITY)))
  end

  def do_something_about_it
    # Get one operator and ARITY operands off the top
    operator = @operators.shift
    @next_operand ||= @operands.shift
    rest_of_operands = []
    (ARITY - 1).times { rest_of_operands <<  @operands.shift }

    @next_operand = @next_operand.send(operator, *rest_of_operands)
  end

  def run
    receive_input
    do_math
    tell_us_how_much
  end

  private

  def readlines
    gets.chomp
  end

  def parse(input)
    input.split
  end

  def tell_us_how_much
    puts @next_operand
  end

  def complain_politely(reason)
    puts "Characters #{reason} don't seem to be numbers or accepted operators."
  end
end
