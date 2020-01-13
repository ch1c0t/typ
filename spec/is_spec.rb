require 'helper'

describe '.is' do
  context 'when a Symbol was passed' do
    typ do
      is :empty?
    end

    good []
    bad [1]
  end

  context 'when an Array was passed' do
    context 'when the first element is a Symbol' do
      typ do
        is [:>, 0]
      end

      good 1
      bad -1, fails: 1
    end

    context 'when the second element is a Symbol' do
      typ do
        is [1...3, :include?]
      end

      good 2
      bad 4
    end

    context 'when the first and second elements are not Symbols' do
      it 'raises an error during definition' do
        expect {
          Class.new do
            include Typ
            is [1, 2, 3]
          end
        }.to raise_error Typ::Error::CannotCreateGate,
        "Don't know how to create #is from a Array: [1, 2, 3]."
      end
    end
  end

  context 'when a Typ was passed' do
    typ do
      is Class.new {
        include Typ

        is [:is_a?, String]
        is [:include?, ?a]
      }
      is [:include?, ?b]
    end

    good 'abba'
    bad 'cd', fails: 2
    bad 'aa', fails: 1
  end

  context 'when a wrong object was passed' do
    it 'raises an error' do
      expect {
        Class.new do
          include Typ
          is 42
        end
      }.to raise_error Typ::Error::CannotCreateGate,
      "Don't know how to create #is from a Integer: 42."

      expect {
        Class.new do
          include Typ
          is Object
        end
      }.to raise_error Typ::Error::CannotCreateGate,
      "Don't know how to create #is from a Class: Object."
    end
  end
end # .is
