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
end
