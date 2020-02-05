require 'helper'

describe '.is_a' do
  describe do
    typ do
      its :size, [:==, 3]
    end

    good [1,2,3]
    bad Object, error: "#<NoMethodError: undefined method `size' for Object:Class>"
  end
end
