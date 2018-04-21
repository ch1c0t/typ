class Typ
  module Singleton
    module DSL
      def is_a type
        case type
        when Array
          gates << Gate.from_array(type)
        end
      end
    end
  
    def gates
      @gates ||= []
    end
    
    include DSL
  end

  def initialize object
    @object = object
    @gates = self.class.gates.map { |gate| gate.new object }
    @fails = @gates.reject &:ok?
  end
  
  attr_reader :object, :gates, :fails
  
  def ok?
    @fails.empty?
  end
  
  def to object
  end
  
  extend Singleton

  class Gate
    class << self
      attr_accessor :check
    
      def from_array array
        check = if array[0].is_a?(Symbol)
          method, *arguments = array
          -> receiver { receiver.send method, *arguments }
        elsif array[1].is_a?(Symbol)
          receiver, method = array
          -> argument { receiver.send method, argument }
        else
          fail "not sure how to handle #{array} yet"
        end
    
        gate = Class.new self
        gate.check = check
        gate
      end
    end
    
    def initialize object
      @ok = self.class.check[object]
    end
    
    def ok?
      @ok
    end
  end
end
