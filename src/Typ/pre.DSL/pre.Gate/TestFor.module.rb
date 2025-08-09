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
