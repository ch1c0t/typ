class Check
  def initialize symbol
    @check = -> it { it.send symbol }
  end

  def === it
    @check === it
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

include Gate
