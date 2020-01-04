def gates
  @gates ||= []
end

def is type
  case type
  when Symbol
    gates << Is::Symbol.new(type)
  when Array
    unless type[0].is_a?(Symbol) || type[1].is_a?(Symbol)
      fail CannotCreateGate.new(__method__, type)
    end

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
