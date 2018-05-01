require 'helper'

describe Typ::IsA do
  it '#it' do
    is_a = described_class.new String
    gate = is_a.new 'some'
    assert { gate.it == 'some' }
  end

  describe Typ::IsA::Type do
    describe '#to_s'  do
      it 'without params' do
        type = described_class.new Hash
        expect(type.to_s).to eq 'Hash'
      end

      it 'with params' do
        type = described_class.new Hash, Symbol => String
        expect(type.to_s).to eq 'Hash, {Symbol=>String}'
      end
    end
  end
end
