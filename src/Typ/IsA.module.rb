class << self
  def new type
    check = -> it { it.is_a? type }

    gate = Class.new
    gate.include self
    gate.type, gate.check = type, check
    gate
  end
end

def self.included gate
  gate.extend Singleton
end

module Singleton
  attr_accessor :type, :check
end

def ok?
  @ok
end

def initialize it
  @it = it
  @ok = self.class.check[it]
end

attr_reader :it
