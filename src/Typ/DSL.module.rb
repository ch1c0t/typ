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
      fail "don't know how to create a Gate from #{type}"
    end
  else
    fail "don't know how to create a Gate from #{type}"
  end
end

def is_a type
  case type
  when Module
    gates << IsA.new(type)
  end
end
