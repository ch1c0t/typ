require 'helper'

describe '.is_a' do
  context 'when a Module was passed' do
    context 'without params' do
      let :string do
        Class.new do
          include Typ
          is_a String
        end
      end

      it 'passes' do
        typ = string.new 'indeed a String'
        assert { typ.ok? }
      end

      it 'fails' do
        typ = string.new :some_symbol
        assert { not typ.ok? }
      end
    end

    context 'with params' do
      context 'Hash' do
        let :typ_class do
          Class.new do
            include Typ
            is_a Hash, Symbol => String
          end
        end

        it 'passes' do
          hash = { a: 'some string', b: 'another string' }
          typ = typ_class.new hash
          assert { typ.ok? }
        end

        it 'fails when not a Hash was passed' do
          array = [1,2,3]
          typ = typ_class.new array
          assert { not typ.ok? }
        end

        it 'fails when keys have wrong types' do
          hash = { 'a' => 'some string', 'b' => 'another string' }
          typ = typ_class.new hash
          assert { not typ.ok? }
        end

        it 'fails when values have wrong types' do
          hash = { a: 1, b: 2 }
          typ = typ_class.new hash
          assert { not typ.ok? }
        end
      end

      context 'Array' do
        let :typ_class do
          Class.new do
            include Typ
            is_a Array, of: Symbol
          end
        end

        it 'passes' do
          array = [:a,:b,:c]
          typ = typ_class.new array
          assert { typ.ok? }
        end

        it 'fails when not an Array was passed' do
          hash = {}
          typ = typ_class.new hash
          assert { not typ.ok? }
        end

        it 'fails when not an Array of Symbols was passed' do
          array = [1,2,3]
          typ = typ_class.new array
          assert { not typ.ok? }
        end
      end
    end
  end

  context 'when a wrong object was passed' do
    it 'raises an error' do
      expect {
        Class.new do
          include Typ
          is_a 1
        end
      }.to raise_error Typ::DSL::CannotCreateGate,
      "Don't know how to create #is_a from 1"
    end
  end
end
