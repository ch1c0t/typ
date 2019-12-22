module DSL
  def typ name = :typ, &block
    let name do
      Class.new do
        include Typ
        instance_exec &block
      end
    end
  end
end
