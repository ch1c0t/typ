def test_for type
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

def cannot_create_gate type
  fail Typ::Error::CannotCreateGate.new(type)
end

def bad_assertion it, name
  fail Typ::Error::BadAssertion.new(it, name)
end
