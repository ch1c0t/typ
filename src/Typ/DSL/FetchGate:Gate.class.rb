using ArrayPredicate
using ArrayToTest

def make
  type_check = test_for @literal
  @test = fetch_check >> type_check
  enrich_gate
end

def test_for literal
  case literal
  when Integer
    super [:eql?, literal]
  when Symbol
    if literal.end_with? ??
      super
    else
      super [:eql?, literal]
    end
  when Array
    literal.predicate? ? literal.to_test : (super [:eql?, literal])
  else
    super
  end
end
