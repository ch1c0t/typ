require 'helper'

describe Typ::Gate do
  context 'works' do
    let :typ_class do
      Class.new do
        include Typ
        is [:>, 0]
      end
    end

    let(:object) { 1 }
    let(:typ) { typ_class.new object }
    let(:gate) { typ.gates.first }

    it '#dsl_method' do
      assert { gate.dsl_method == :is }
    end

    it '#dsl_literal' do
      assert { gate.dsl_literal == [:>, 0] }
    end
  end
end
