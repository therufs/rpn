#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'rpn'

puts 'ctrl + D or q to quit'
calculator = RpnCalculator.new
begin
  loop { calculator.run }
rescue NoMethodError # why? i cannot say.
  exit
end
