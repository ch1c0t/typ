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
    it "#{value} is #{name}" do
      typ = eval name.to_s
      instance = typ.new value

      expect(instance.ok?).to be true
      instance_exec instance, &block if block_given?
    end
  end

  def bad value, name = :t, &block
    it "#{value} is not #{name}" do
      typ = eval name.to_s
      instance = typ.new value

      expect(instance.ok?).to be false
      instance_exec instance, &block if block_given?
    end
  end
end
