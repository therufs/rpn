class RpnCalculator

# Consume a series of numbers, followed by a series of operands.
# When a sufficient arity of numbers per operand is available,
# execute the operation and return the value.
# Use the returned value as the first argument.

  OPERATORS = %w(+ - / *)

  def initialize
    @arguments = []
    @operators = []
  end

  def calculate
    while true
      receive_input
      perform_operations
    end
  end

  def receive_input
    number_pattern = /[0-9]+/ # ruby helpfully casts anything that isn't a number to 0
    provided = gets.chomp.split
    provided.each do |p|

      if number_pattern.match p # this isn't very POODR :(
        @arguments << p
      elsif OPERATORS.include? p
        @operators << p.to_sym # YUCK
      elsif p == "q" # maybe should require q to be a single length input in case of mistypes
        exit
      end
    end
    puts "arguments: #{@arguments.to_s}"
    puts "operators: #{@operators.to_s}"
  end

  def perform_operations
  end
end

puts "ctrl + C to quit"
calculator = RpnCalculator.new
calculator.calculate
