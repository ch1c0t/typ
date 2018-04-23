def is type
  case type
  when Array
    gates << Gate::FromArray[type]
  when Class
    if type.include? Typ
      gates << Gate::FromTyp[type]
    else
      fail "don't know how to create a Gate from #{type}"
    end
  else
    fail "don't know how to create a Gate from #{type}"
  end
end
