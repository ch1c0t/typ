require 'helper'

describe '.is_a' do
  context 'works' do
    typ do
      is_a String
    end

    good 'string'
    bad :symbol
  end
end
