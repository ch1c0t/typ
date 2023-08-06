refine Object do
  def bad_assertion it, name
    fail Typ::Error::BadAssertion.new(it, name)
  end
end

refine Array do
  def to_test
    type = self

    if type[0].is_a? Symbol
      method, argument = type
      -> it { it.send method, argument or bad_assertion(it, type) }
    else
      receiver, method = type
      -> it { receiver.send method, it or bad_assertion(it, type) }
    end
  end
end
