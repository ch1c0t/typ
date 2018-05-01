def self.included mod
  mod.extend DSL
end

include Gate

attr_reader :gates, :fails

def check
  @gates = self.class.gates.map { |gate| gate.new it }
  @fails = gates.reject &:ok?
  @ok = fails.empty?
end
