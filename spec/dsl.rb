module DSL
  def typ name = :t, &block
    let name do
      Class.new do
        include Typ
        instance_exec &block
      end
    end
  end

  def good value, name = :t, &block
    it "(#{value} should be #{name})" do
      typ = eval name.to_s
      instance = typ.new value

      expect(instance.ok?).to be true
      instance_exec instance, &block if block_given?
    end
  end

  def bad value, name = :t, fails: nil, error: nil, &block
    it "(#{value} should not be #{name})" do
      typ = eval name.to_s
      instance = typ.new value

      expect(instance.ok?).to be false

      if fails
        expect(instance.fails.size).to eq fails
      end

      if error
        e = instance.fails[0].error.inspect
        expect(e).to eq error
      end

      instance_exec instance, &block if block_given?
    end
  end
end
