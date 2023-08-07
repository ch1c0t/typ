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

  context 'Arrays' do
    context 'as predicates' do
      context 'when the first element is the method' do
        typ do
          its :to_a, [:include?, 3]
        end

        good [1,2,3]
        good [3]
        bad [1,2],
          error: "#<Typ::Error::BadAssertion: [1, 2] is [:include?, 3]>"
      end

      context 'when the second element is the method' do
        typ do
          its :to_s, ['string', :include?]
        end

        good 'ing'
        good 'i'
        bad 'a',
          error: '#<Typ::Error::BadAssertion: "a" is ["string", :include?]>'
      end
    end

    context 'as values' do
      context 'when the size is smaller or larger than 2' do
        typ do
          its :to_a, [:a, :b, :c]
        end

        good [:a, :b, :c]
        bad [:a],
          error: '#<Typ::Error::BadAssertion: [:a] is [:eql?, [:a, :b, :c]]>'
      end

      context 'without Symbols, when the size is 2' do
        typ do
          its :to_a, [1,2]
        end

        good [1,2]
        bad [1],
          error: '#<Typ::Error::BadAssertion: [1] is [:eql?, [1, 2]]>'
      end
    end
  end

  context 'Classes' do
    context 'as predicates' do
      before do
        nested_Typ = Class.new do
          include Typ
          is [:>, 0]
        end

        @Typ = Class.new do
          include Typ
          its :nested, nested_Typ
        end
      end

      it 'passes if the nested attribute is more than 0' do
        object = Struct.new(:nested).new(1)
        typ = @Typ.new object

        expect(typ.ok?).to be true
      end

      it 'fails if the nested attribute is 0' do
        object = Struct.new(:nested).new(0)
        typ = @Typ.new object

        expect(typ.ok?).to be false
      end
    end

    context 'as values' do
      typ do
        its :nested, String
      end

      good Struct.new(:nested).new(String)
      bad Struct.new(:nested).new(:not_String_class),
        error: '#<Typ::Error::BadAssertion: :not_String_class is [:eql?, String]>'
    end
  end
end
