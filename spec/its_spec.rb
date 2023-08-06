require 'helper'

describe '.its' do
  context 'its :size, [:==], 3' do
    typ do
      its :size, [:==, 3]
    end

    good [1,2,3]
    bad [1,2], error: "#<Typ::Error::BadAssertion: 2 is [:==, 3]>"
    bad Object, error: "#<NoMethodError: undefined method `size' for Object:Class>"

    it 'has the DSL readers' do
      gate = t.new([]).gates.first

      assert { gate.dsl_method == :its }
      assert { gate.dsl_literal == [:==, 3] }
      assert { gate.dsl_key == :size }
    end
  end

  context 'its :size, 3' do
    typ do
      its :size, 3
    end

    good [1,2,3]
    bad [1,2], error: "#<Typ::Error::BadAssertion: 2 is [:eql?, 3]>"
    bad Object, error: "#<NoMethodError: undefined method `size' for Object:Class>"
  end

  context 'symbolic literals' do
    context 'when a Symbol ends with a question mark' do
      typ do
        its :to_s, :empty?
      end

      good ''
      bad 'non-empty string'
    end

    context 'when a Symbol does not end with a question mark' do
      typ do
        its :to_sym, :empty
      end

      good :empty
      good 'empty'
      bad :some_other_symbol,
        error: "#<Typ::Error::BadAssertion: :some_other_symbol is [:eql?, :empty]>"
      bad 'some_other_string',
        error: '#<Typ::Error::BadAssertion: :some_other_string is [:eql?, :empty]>'
    end
  end
end
