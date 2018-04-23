require_relative 'helper'

describe Typ do
  it 'has the public API' do
    it = 1

    typ = Class.new do
      include Typ
      is [:>, 0]
    end

    instance = typ.new it

    assert { instance.it.eql? it }
    assert { instance.ok? }

    assert { instance.gates.is_a? Array }
    assert { instance.gates.size == 1 }

    assert { instance.fails.is_a? Array }
    assert { instance.fails.empty? }
  end

  describe '.is' do
    context 'when an Array was passed' do
      context 'when the first element is a Symbol' do
        let :positive do
          Class.new do
            include Typ
            is [:>, 0]
          end
        end

        it 'passes' do
          typ = positive.new 1

          assert { typ.ok? }
          assert { typ.gates.size == 1 }
        end

        it 'fails' do
          typ = positive.new -1

          assert { not typ.ok? }
          assert { typ.gates.size == 1 }
          assert { typ.fails.size == 1 }
        end
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
          is StringWhichIncludesA
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
    end
  end
end
