def initialize object
  @object = object
  @gates = self.class.gates.map { |gate| gate.new object }
  @fails = gates.reject &:ok?
end

attr_reader :object, :gates, :fails

def ok?
  fails.empty?
end

extend Singleton
