require 'helper'

describe Typ do
  let :typ_class do
    Class.new do
      include Typ
      is [:>, 0]
    end
  end

  let(:it) { 1 }
  let(:typ) { typ_class.new it }

  it '#ok?' do
    assert { typ.ok? }
  end

  it '#it' do
    assert { typ.it.eql? it }
  end

  it '#gates' do
    assert { typ.gates.is_a? Array }
    assert { typ.gates.size == 1 }
  end

  it '#fails' do
    assert { typ.fails.is_a? Array }
    assert { typ.fails.empty? }
  end
end
