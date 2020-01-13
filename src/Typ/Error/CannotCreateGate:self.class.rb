def initialize name, object
  message = "Don't know how to create ##{name} from a #{object.class}: #{object.inspect}."
  super message
end
