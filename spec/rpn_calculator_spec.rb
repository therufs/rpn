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
      expect(@calc.result).to eq 2
    end

    describe 'non-commutative operations' do
      it 'subtracts' do
        @calc.receive_input('3 1 -')
        @calc.do_math
        expect(@calc.result).to eq 2
        expect(@calc.result).not_to eq(-2)
      end

      it 'divides' do
        @calc.receive_input('15 3 /')
        @calc.do_math
        expect(@calc.result).to eq 5
      end
    end

    describe 'complex inputs' do
      it 'correctly handles longer inputs' do
        @calc.receive_input('5 5 5 8 + + -')
        @calc.do_math
        expect(@calc.result).to eq(-13)
      end

      it 'handles interleaved input types' do
        @calc.receive_input('5 6 + 3 -')
        @calc.do_math

        second_calc = RpnCalculator.new
        second_calc.receive_input('5 6 3 + -')
        second_calc.do_math

        expect(@calc.result).not_to eq second_calc.result
        expect(@calc.result).to eq(8)
        expect(second_calc.result).to eq(-4)
      end

      it 'handles interleaved input types (second example)' do
        @calc.receive_input('3 4 + 5 6 + *')
        @calc.do_math

        expect(@calc.result).to eq(77)
      end

      it 'operates on multiple inputs' do
        @calc.receive_input('5 8 +')
        @calc.do_math
        expect(@calc.result).to eq 13

        @calc.receive_input('13 +')
        @calc.do_math
        expect(@calc.result).to eq 26
      end

      it 'manages superfluous operators' do
        @calc.receive_input('9 3 - + +')
        @calc.do_math
        expect(@calc.result).to eq 6

        @calc.receive_input('5')
        @calc.do_math
        expect(@calc.result).to eq 11
      end
    end
  end

  describe 'non-arithmetic operations' do
    before do
      @calc.receive_input('3 1 -')
      @calc.do_math
      expect(@calc.result).to eq 2
    end

    it 'clears buffers' do
      @calc.receive_input('c')
      expect(@calc.result).to be nil

      @calc.receive_input('5 1 -')
      @calc.do_math
      expect(@calc.result).to eq 4
    end

    it 'quits with q when told' do
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

  xit 'orchestrates its components in joyous symphony' do
    # integration tests go here
  end
end
