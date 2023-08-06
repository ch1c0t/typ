def make
  type_check = test_for @literal
  @test = fetch_check >> type_check
  enrich_gate
end

def test_for literal
  if literal.is_a? Integer
    super [:eql?, literal]
  else
    super
  end
end
