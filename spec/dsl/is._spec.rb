require 'helper'

describe '.is' do
  context 'when an Array was passed' do
    context 'when the first element is a Symbol' do
      typ do
        is [:>, 0]
      end

      good 1
      bad -1, fails: 1
    end

    context 'when the second element is a Symbol' do
      let :between_one_and_three do
        Class.new do
          include Typ
          is [1...3, :include?]
        end
      end

      it 'passes' do
        typ = between_one_and_three.new 2

        assert { typ.ok? }
        assert { typ.gates.size == 1 }
      end

      it 'fails' do
        typ = between_one_and_three.new 4

        assert { not typ.ok? }
        assert { typ.gates.size == 1 }
        assert { typ.fails.size == 1 }
      end
    end

    context 'when the first and second elements are not Symbols' do
      it 'raises an error during definition' do
        expect {
          Class.new do
            include Typ
            is [1, 2, 3]
          end
        }.to raise_error RuntimeError
      end
    end
  end

  context 'when a Typ was passed' do
    let :abba_string do
      Class.new do
        include Typ
        is Class.new {
          include Typ

          is [:is_a?, String]
          is [:include?, ?a]
        }
        is [:include?, ?b]
      end
    end

    it 'passes' do
      typ = abba_string.new 'abba'

      assert { typ.ok? }
      assert { typ.gates.size == 2 }
    end

    it 'fails when both gates are not ok' do
      typ = abba_string.new 'cd'

      assert { not typ.ok? }
      assert { typ.gates.size == 2 }
      assert { typ.fails.size == 2 }
    end

    it 'fails when one gates is not ok' do
      typ = abba_string.new 'a'

      assert { not typ.ok? }
      assert { typ.gates.size == 2 }
      assert { typ.fails.size == 1 }
    end
  end # when a Typ was passed

  context 'when a wrong object was passed' do
    it 'raises an error' do
      expect {
        Class.new do
          include Typ
          is :wrong_object
        end
      }.to raise_error Typ::DSL::CannotCreateGate,
      "Don't know how to create #is from wrong_object"

      expect {
        Class.new do
          include Typ
          is Object
        end
      }.to raise_error Typ::DSL::CannotCreateGate,
      "Don't know how to create #is from Object"
    end
  end
end # .is
