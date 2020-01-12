class Check
  def initialize array
    @array = array
    @check = array.to_proc
  end

  def === it
    @check === it
  end
end

class << self
  def new array
    check = Check.new array

    gate = Gate.new
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
