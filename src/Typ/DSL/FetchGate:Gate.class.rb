def make
  type_check = test_for @literal
  @test = fetch_check >> type_check
  enrich_gate
end

def test_for literal
  case literal
  when Symbol
    literal.end_with?(??) ? super : (super [:eql?, literal])
  when Array
    literal.predicate? ? literal.to_test : (super [:eql?, literal])
  when Class
    literal.include?(Typ) ? super : (super [:eql?, literal])
  else
    super [:eql?, literal]
  end
end
