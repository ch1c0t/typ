def make
  @test = test_for [:is_a?, @literal]
  enrich_gate
end
