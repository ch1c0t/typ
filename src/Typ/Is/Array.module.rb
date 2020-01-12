class << self
  def new array
    test = array.to_proc
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
