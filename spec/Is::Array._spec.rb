require 'helper'

describe Typ::IsA do
  it '#it' do
    is_a = described_class.new String
    gate = is_a.new 'some'
    assert { gate.it == 'some' }
  end
end
