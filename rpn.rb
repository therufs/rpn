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
  NUMBER_PATTERN = /[0-9]+/ # Ruby helpfully casts anything that isn't a number to 0
  ARITY = 2

  attr_reader :result

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
        do_math
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
    ops_length = @operands.length
    @operators.any? && ops_length >= ARITY
  end

  def do_something_about_it
    # Get one operator and ARITY operands off the top
    operator = @operators.pop
    next_operand = @operands.pop
    subject = @operands.pop

    @result = subject.send(operator, next_operand)
    @operands << @result
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
    puts @result
  end

  def complain_politely(reason)
    puts "Characters #{reason} don't seem to be numbers or accepted operators."
  end

  def clear
    @operands = []
    @operators = []
    @result = nil
  end
end
