def gates
  @gates ||= []
end

def is literal
  gates << Is.new(__method__, literal).gate
end

def is_a literal
  gates << IsA.new(__method__, literal).gate
end

def its name, literal
  gates << Its.new(__method__, literal, name: name).gate
end

def key name, literal
  gates << Key.new(__method__, literal, name: name).gate
end
