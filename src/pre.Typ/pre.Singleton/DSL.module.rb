def is_a type
  case type
  when Array
    gates << Gate::FromArray[type]
  end
end
