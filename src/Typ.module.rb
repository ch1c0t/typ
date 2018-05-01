def self.included mod
  mod.extend DSL
end

def initialize it
  @it = it
  check
end

attr_reader :it, :gates, :fails

def check
  @gates = self.class.gates.map { |gate| gate.new it }
  @fails = gates.reject &:ok?
  @ok = fails.empty?
end

def ok?
  @ok
end
