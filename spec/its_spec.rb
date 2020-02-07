require 'helper'

describe '.its' do
  describe do
    typ do
      its :size, [:==, 3]
    end

    good [1,2,3]
    bad [1,2], error: "#<Typ::Error::BadAssertion: 2 is [:==, 3]>"
    bad Object, error: "#<NoMethodError: undefined method `size' for Object:Class>"
  end
end
