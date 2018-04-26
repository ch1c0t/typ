class << self
  def new array
    check = if array[0].is_a?(Symbol)
      method, *arguments = array
      -> receiver { receiver.send method, *arguments }
    elsif array[1].is_a?(Symbol)
      receiver, method = array
      -> argument { receiver.send method, argument }
    else
      fail "not sure how to handle #{array} yet"
    end

    gate = Class.new
    gate.include self
    gate.check, gate.array = check, array
    gate
  end
end

def self.included gate
  gate.extend Singleton
end

module Singleton
  attr_accessor :check, :array
end

def to_a
  self.class.array
end

def ok?
  @ok
end

def initialize it
  @ok = self.class.check[it]
end
