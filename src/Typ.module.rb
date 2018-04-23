def self.included mod
  mod.extend DSL
end

def initialize it
  @it = it
  @gates = self.class.gates.map { |gate| gate.new it }
  @fails = gates.reject &:ok?
end

attr_reader :it, :gates, :fails

def ok?
  fails.empty?
end
