def gates
  @gates ||= []
end

def is type
  case type
  when Array
    gates << Is::Array.new(type)
  when Class
    if type.include? Typ
      gates << type
    else
      fail CannotCreateGate.new(__method__, type)
    end
  else
    fail CannotCreateGate.new(__method__, type)
  end
end

def is_a type, params = {}
  case type
  when Module
    gates << IsA.new(type, params)
  else
    fail CannotCreateGate.new(__method__, type)
  end
end
