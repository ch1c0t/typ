def is_a type
  case type
  when Array
    gates << Gate.from_array(type)
  end
end
