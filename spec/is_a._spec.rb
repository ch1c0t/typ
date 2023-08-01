require 'helper'

describe '.is_a' do
  context 'works' do
    typ do
      is_a String
    end

    good 'string'
    bad :symbol

    it 'has correct #dsl_method and #dsl_literal' do
      gate = t.new('string').gates.first

      assert { gate.dsl_method == :is_a }
      assert { gate.dsl_literal == String }
    end
  end
end
