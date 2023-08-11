def make
  type_check = test_for @literal
  @test = fetch_check >> type_check
  enrich_gate
end

def test_for literal
  case literal
  when Symbol
    literal.end_with?(??) ? super : [:eql?, literal].to_test
  when Array
    literal.predicate? ? literal.to_test : [:eql?, literal].to_test
  when Class
    literal.include?(Typ) ? super : [:eql?, literal].to_test
  else
    [:eql?, literal].to_test
  end
end
