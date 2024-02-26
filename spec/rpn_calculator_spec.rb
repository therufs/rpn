# frozen_string_literal: true

require './rpn'

describe RpnCalculator do
  before do
    @calc = RpnCalculator.new
  end

  describe 'calculation' do
    it 'correctly performs simple arithmetic' do
      @calc.receive_input('1 1 +')
      @calc.do_math
      expect(@calc.next_operand).to eq 2
    end

    describe 'non-commutative operations' do
      it 'subtracts' do
        @calc.receive_input('3 1 -')
        @calc.do_math
        expect(@calc.next_operand).to eq 2
        expect(@calc.next_operand).not_to eq(-2)
      end

      it 'divides' do
        @calc.receive_input('15 3 /')
        @calc.do_math
        expect(@calc.next_operand).to eq 5
      end
    end

    describe 'complex inputs' do
      it 'correctly handles longer inputs' do
        @calc.receive_input('5 5 5 8 + + -')
        @calc.do_math
        expect(@calc.next_operand).to eq(-13)
      end

      it 'handles interleaved input types' do
        @calc.receive_input('5 6 + 3 -')
        @calc.do_math

        second_calc = RpnCalculator.new
        second_calc.receive_input('5 6 3 + -')
        second_calc.do_math

        expect(@calc.next_operand).to eq second_calc.next_operand
        expect(@calc.next_operand).to eq(-4)
      end

      it 'operates on multiple inputs' do
        @calc.receive_input('5 8 +')
        @calc.do_math
        expect(@calc.next_operand).to eq 13

        @calc.receive_input('13 +')
        @calc.do_math
        expect(@calc.next_operand).to eq 26
      end

      it 'manages superfluous operators' do
        @calc.receive_input('9 3 - + +')
        @calc.do_math
        expect(@calc.next_operand).to eq 6

        @calc.receive_input('5')
        @calc.do_math
        expect(@calc.next_operand).to eq 11
      end
    end
  end

  describe 'non-arithmetic operations' do
    before do
      @calc.receive_input('3 1 -')
      @calc.do_math
      expect(@calc.next_operand).to eq 2
    end

    it 'clears buffers' do
      @calc.receive_input('c')
      expect(@calc.next_operand).to be nil

      @calc.receive_input('5 1 -')
      @calc.do_math
      expect(@calc.next_operand).to eq 4
    end

    it 'quits when told' do
      expect { @calc.receive_input('q') }.to raise_error SystemExit
    end
  end

  describe 'IO' do
    describe 'stdin/stdout' do
      xit 'consumes numbers from stdin' do
      end

      xit 'prints results to stdout' do
      end
    end
  end

  xit 'orchestrates its components work in joyous symphony' do
    # integration test goes here
  end
end
