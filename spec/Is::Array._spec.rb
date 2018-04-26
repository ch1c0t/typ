require_relative 'helper'

describe Typ::Is::Array do
  it '#to_a' do
    is_array = described_class.new [:>, 0]
    gate = is_array.new 1
    assert { gate.to_a == [:>, 0] }
  end
end
