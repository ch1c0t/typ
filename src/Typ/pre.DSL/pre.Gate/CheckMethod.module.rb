def augment_gate_with_check test
  check = Module.new do
    define_method :check do
      test[it]
    end
  end

  gate.include check
end
