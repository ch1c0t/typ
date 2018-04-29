require 'helper'

describe '.is_a' do
  context 'when a Module was passed' do
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

  context 'when a wrong object was passed' do
    it 'raises an error' do
      expect {
        Class.new do
          include Typ
          is_a 1
        end
      }.to raise_error RuntimeError, "don't know how to create a Gate from 1"
    end
  end
end
