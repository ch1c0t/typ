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
end
