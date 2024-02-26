# frozen_string_literal: true

# The RPN Calculator accepts a series of numbers and basic operators (+ - * /).
# The last full set of elements passed will be evaluated in subject-object-verb
# order. The result is then supplied as the object for the next set of elements.

# Step-by-step example: 5 8 2 - -
# > 8 2 -
# > 6
# > 5 -
# > -1
class RpnCalculator
  OPERATORS = %w[+ - / *].freeze
  NUMBER_PATTERN = /[0-9]+/ # ruby helpfully casts anything that isn't a number to 0
  ARITY = 2

  attr_reader :next_operand

  def initialize
    @operands = []
    @operators = []
  end

  def receive_input(input = nil)
    if input.nil?
      puts 'awaiting input ...'
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
    parsed_input.each do |p| # :(
      if NUMBER_PATTERN.match p
        @operands << p.to_f
      elsif OPERATORS.include? p
        @operators << p.to_sym
      elsif p == 'q'
        exit
      elsif p == 'c'
        clear
      else
        complain_politely(p)
      end
    end
  end

  def do_math
    do_something_about_it while enough_to_work_with_on_the_stacks?
  end

  def enough_to_work_with_on_the_stacks?
    # will need to surface this into args if ever a non-binary operator
    ops_length = @operands.length
    @operators.any? && (ops_length >= ARITY || (@next_operand && (ops_length + 1 >= ARITY)))
  end

  def do_something_about_it
    # Get one operator and ARITY operands off the top
    operator = @operators.shift
    @next_operand ||= @operands.pop
    subject = @operands.pop

    @next_operand = subject.send(operator, @next_operand)
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

  def clear
    @operands = []
    @operators = []
    @next_operand = nil
  end
end
