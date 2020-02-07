def gates
  @gates ||= []
end

def is type
  test = make_test_for type

  if test
    gate = (Class === type) ? type : make_gate_with(test)
    gates << gate
  else
    cannot_create_gate type
  end
end

def its name, type
  fetch_name = -> it { it.send name }
  check_type = make_test_for type

  test = fetch_name >> check_type
  gates << make_gate_with(test)
end

private
  def make_test_for type
    case type
    when Symbol
      -> it { it.send type or bad_assertion(it, type) }
    when Array
      cannot_create_gate type unless type.size == 2
      unless type[0].is_a?(Symbol) || type[1].is_a?(Symbol)
        cannot_create_gate type
      end

      if type[0].is_a? Symbol
        method, argument = type
        -> it { it.send method, argument or bad_assertion(it, type) }
      else
        receiver, method = type
        -> it { receiver.send method, it or bad_assertion(it, type) }
      end
    when Class
      type if type.include? Typ
    end
  end

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

  def cannot_create_gate type
    fail Error::CannotCreateGate.new(type)
  end

  def bad_assertion it, name
    fail Error::BadAssertion.new(it, name)
  end
