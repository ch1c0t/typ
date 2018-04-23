class << self
  attr_accessor :check
end

def initialize object
  @ok = self.class.check[object]
end

def ok?
  @ok
end
