def self.new
  c = Class.new
  c.include Gate
  c
end

attr_reader :it

def initialize it
  @it = it
  @ok = check
end

def check
end

def ok?
  @ok
end
