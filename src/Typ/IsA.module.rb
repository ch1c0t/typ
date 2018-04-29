class << self
  def new type
    check = -> it { it.is_a? type }

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

def ok?
  @ok
end

def initialize it
  @ok = self.class.check[it]
end
