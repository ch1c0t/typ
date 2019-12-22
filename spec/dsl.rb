module DSL
  def typ name = :typ, &block
    let name do
      Class.new do
        include Typ
        instance_exec &block
      end
    end
  end

  def good value, name = :typ, &block
    it "#{value} is #{name}" do
      typ = eval name.to_s
      instance = typ.new value

      expect(instance.ok?).to be true
      instance_exec instance, &block
    end
  end
end
