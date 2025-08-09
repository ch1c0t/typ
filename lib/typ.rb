module Typ
  module ArrayPredicate
    refine Array do
      def predicate?
        (size == 2) &&
          (self[0].is_a?(Symbol) || self[1].is_a?(Symbol))
      end
    end
  end

  module ArrayToTest
    refine Object do
      def bad_assertion object, name
        fail Typ::Error::BadAssertion.new(object, name)
      end
    end
    
    refine Array do
      def to_test
        type = self
    
        if type[0].is_a? Symbol
          method, argument = type
          -> object { object.send method, argument or bad_assertion(object, type) }
        else
          receiver, method = type
          -> object { receiver.send method, object or bad_assertion(object, type) }
        end
      end
    end
  end

  module Gate
    module DSLReaders
      def dsl_method
        self.class.dsl_method
      end
      
      def dsl_literal
        self.class.dsl_literal
      end
      
      def dsl_key
        self.class.dsl_key
      end
    end
  
    module Name
      attr_writer :name
      
      def name
        @name ||= self.class.to_s
      end
    end
  
    module New
      def new
        c = Class.new
        c.include Gate
        c.extend Singleton
        c
      end
      
    end
  
    module Singleton
      attr_accessor :dsl_method, :dsl_literal, :dsl_key
    end
  
    extend New
    include Name
    include DSLReaders
    
    attr_reader :object, :error
    
    def initialize object
      @object = object
      @ok = begin
              check
            rescue => e
              @error = e
              false
            end
    end
    
    def check
    end
    
    def ok?
      @ok
    end
  end

  using ArrayPredicate
  using ArrayToTest
  
  def self.included mod
    mod.extend DSL
    mod.extend Singleton
  end
  
  include Gate
  
  attr_reader :gates, :fails
  
  def check
    @gates = self.class.gates.map { |gate| gate.new object }
    @fails = gates.reject &:ok?
    fails.empty?
  end

  module DSL
    class Gate
      module CheckMethod
        def augment_gate_with_check test
          check = Module.new do
            define_method :check do
              test[object]
            end
          end
        
          gate.include check
        end
      end
    
      module TestFor
        def test_for type
          case type
          when Symbol
            -> object { object.send type or bad_assertion(object, type) }
          when Array
            type.predicate? ? type.to_test : (cannot_create_gate type)
          when Class
            type if type.include? Typ
          end
        end
        
        def cannot_create_gate type
          fail Typ::Error::CannotCreateGate.new(type)
        end
      end
    
      def initialize method, literal, **kwargs
        @method, @literal, @kwargs = method, literal, kwargs
        make
      end
      
      def gate
        @gate ||= Typ::Gate.new
      end
      
      def make
      end
      
      include TestFor
      include CheckMethod
      
      def enrich_gate
        augment_gate_with_check @test
        gate.dsl_method = @method
        gate.dsl_literal = @literal
        gate.dsl_key = @kwargs[:name]
      end
    end
  
    def gates
      @gates ||= []
    end
    
    def is literal
      gates << Is.new(__method__, literal).gate
    end
    
    def is_a literal
      gates << IsA.new(__method__, literal).gate
    end
    
    def its name, literal
      gates << Its.new(__method__, literal, name: name).gate
    end
    
    def key name, literal
      gates << Key.new(__method__, literal, name: name).gate
    end
  
    class FetchGate < Gate
      def make
        type_check = test_for @literal
        @test = fetch_check >> type_check
        enrich_gate
      end
      
      def test_for literal
        case literal
        when Symbol
          literal.end_with?(??) ? super : [:eql?, literal].to_test
        when Array
          literal.predicate? ? literal.to_test : [:eql?, literal].to_test
        when Class
          literal.include?(Typ) ? super : [:eql?, literal].to_test
        else
          [:eql?, literal].to_test
        end
      end
    end
  
    class Is < Gate
      def make
        @test = test_for @literal
      
        if @test
          if Class === @literal
            @gate = @literal
          else
            enrich_gate
          end
        else
          cannot_create_gate @literal
        end
      end
    end
  
    class IsA < Gate
      def make
        @test = test_for [:is_a?, @literal]
        enrich_gate
      end
    end
  
    class Its < FetchGate
      def fetch_check
        @fetch_check ||= begin
                           name = @kwargs[:name]
                           -> object { object.send name }
                         end
      end
    end
  
    class Key < FetchGate
      def fetch_check
        @fetch_check ||= begin
                           name = @kwargs[:name]
                           -> object { object[name] }
                         end
      end
    end
  end

  class Error < StandardError
  
    class BadAssertion < self
      def initialize object, method_name
        message = "#{object.inspect} is #{method_name}"
        super message
      end
    end
  
    class CannotCreateGate < self
      def initialize object
        message = "Don't know how to create a gate from #{object.inspect}:#{object.class}."
        super message
      end
    end
  end

  module Singleton
    def call object
      new(object).ok?
    end
    
    alias_method :===, :call
  end
end
