def make
  type_check = test_for @literal
  @test = fetch_check >> type_check
  enrich_gate
end
