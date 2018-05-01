class << self
  def new type, params = {}
    type = Type.new type, params

    gate = Class.new
    gate.include self
    gate.type, gate.check = type, type
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
