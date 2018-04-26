def self.included gate
  gate.extend Singleton
end

module Singleton
  attr_accessor :check
end

def initialize object
  @ok = self.class.check[object]
end

def ok?
  @ok
end
