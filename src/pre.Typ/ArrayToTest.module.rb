refine Object do
  def bad_assertion object, name
    fail Typ::Error::BadAssertion.new(object, name)
  end
end

refine Array do
  def to_test
    type = self

    if type[0].is_a? Symbol
      method, argument = type
      -> object { object.send method, argument or bad_assertion(object, type) }
    else
      receiver, method = type
      -> object { receiver.send method, object or bad_assertion(object, type) }
    end
  end
end
