refine Array do
  def predicate?
    (size == 2) &&
      (self[0].is_a?(Symbol) || self[1].is_a?(Symbol))
  end
end
