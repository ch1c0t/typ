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
end
