require_relative 'helper'

describe Typ do
  it 'has the public API' do
    object = Object.new
    typ = Typ.new object

    assert { typ.object.eql? object }
    assert { typ.ok? }

    assert { typ.gates.is_a? Array }
    assert { typ.gates.empty? }

    assert { typ.fails.is_a? Array }
    assert { typ.fails.empty? }

    assert { typ.respond_to? :to }
  end

  describe '.is' do
    context 'when an Array was passed' do
      context 'when the first element is a Symbol' do
        let :positive do
          Class.new Typ do
            is_a [:>, 0]
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
          Class.new Typ do
            is_a [1...3, :include?]
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
            Class.new Typ do
              is_a [1, 2, 3]
            end
          }.to raise_error RuntimeError
        end
      end
    end
  end
end
