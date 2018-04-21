def initialize object
  @object = object
  @gates, @fails = [], []
end

attr_reader :object, :gates, :fails

def ok?
  @fails.empty?
end

def to object
end
