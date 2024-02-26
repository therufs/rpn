#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'rpn'

puts 'ctrl + C or q to quit'
calculator = RpnCalculator.new
loop { calculator.run }
