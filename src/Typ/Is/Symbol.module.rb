class << self
  def new symbol
    test = -> it { it.send symbol }
    mod = Module.new do
      define_method :check do
        test[it]
      end
    end

    gate = Gate.new
    gate.include mod
    gate
  end
end
