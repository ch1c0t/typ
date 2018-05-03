class Check
  def initialize array
    @array = array
    @check = if array[0].is_a?(Symbol)
      method, *arguments = array
      -> it { it.send method, *arguments }
    elsif array[1].is_a?(Symbol)
      receiver, method = array
      -> it { receiver.send method, it }
    else
      fail "not sure how to handle #{array} yet"
    end
  end

  def === it
    @check === it
  end

  def to_a
    @array
  end
end

class << self
  def new array
    check = Check.new array

    gate = Class.new
    gate.include self
    gate.check = check
    gate
  end
end

def self.included gate
  gate.extend Singleton
end

module Singleton
  attr_accessor :check
end

def to_a
  self.class.check.to_a
end

include Gate
