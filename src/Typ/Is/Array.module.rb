class Check
  def initialize array
    @array = array
    @check = array.to_proc
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
