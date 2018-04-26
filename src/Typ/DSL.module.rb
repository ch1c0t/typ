def gates
  @gates ||= []
end

def is type
  case type
  when Array
    gates << Is::Array[type]
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
