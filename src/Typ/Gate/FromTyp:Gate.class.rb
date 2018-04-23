class << self
  def [] typ
    check = -> it { typ.new(it).ok? }
    gate = Class.new self
    gate.check = check
    gate
  end
end
