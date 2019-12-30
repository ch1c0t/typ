attr_reader :it

def initialize it
  @it = it
  @ok = check
end

def check
  self.class.check === it
end

def ok?
  @ok
end
