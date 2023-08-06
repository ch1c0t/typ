def test_for type
  case type
  when Symbol
    -> it { it.send type or bad_assertion(it, type) }
  when Array
    type.predicate? ? type.to_test : (cannot_create_gate type)
  when Class
    type if type.include? Typ
  end
end

def cannot_create_gate type
  fail Typ::Error::CannotCreateGate.new(type)
end
