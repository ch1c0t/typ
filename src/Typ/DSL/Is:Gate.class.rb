def make
  @test = test_for @literal

  if @test
    if Class === @literal
      @gate = @literal
    else
      enrich_gate
    end
  else
    cannot_create_gate @literal
  end
end
