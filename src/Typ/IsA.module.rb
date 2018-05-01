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

include Gate
