#!/usr/bin/env ruby

require_relative './rpn'

puts "ctrl + C or q to quit"
calculator = RpnCalculator.new
calculator.run while true
