def call object
  new(object).ok?
end

alias_method :===, :call
