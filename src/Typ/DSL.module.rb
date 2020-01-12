def gates
  @gates ||= []
end

def is type
  case type
  when Symbol
    symbol = type
    test = -> it { it.send symbol }
    gates << make_gate_with(test)
  when Array
    array = type

    unless array[0].is_a?(Symbol) || array[1].is_a?(Symbol)
      fail CannotCreateGate.new(__method__, type)
    end

    test = array.to_proc
    gates << make_gate_with(test)
  when Class
    if type.include? Typ
      gates << type
    else
      fail CannotCreateGate.new(__method__, type)
    end
  else
    fail CannotCreateGate.new(__method__, type)
  end
end

private
  def make_gate_with test
    check = Module.new do
      define_method :check do
        test[it]
      end
    end

    gate = Gate.new
    gate.include check
    gate
  end
