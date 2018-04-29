require 'helper'

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
end
