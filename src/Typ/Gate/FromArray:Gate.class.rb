class << self
  attr_accessor :check

  def [] array
    check = if array[0].is_a?(Symbol)
      method, *arguments = array
      -> receiver { receiver.send method, *arguments }
    elsif array[1].is_a?(Symbol)
      receiver, method = array
      -> argument { receiver.send method, argument }
    else
      fail "not sure how to handle #{array} yet"
    end

    gate = Class.new self
    gate.check = check
    gate
  end
end

def initialize object
  @ok = self.class.check[object]
end
