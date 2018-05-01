class << self
  def new type, params = {}
    type = Type.new type, params

    gate = Class.new
    gate.include self
    gate.check = type
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
