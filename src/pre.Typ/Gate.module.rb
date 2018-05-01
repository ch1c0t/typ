attr_reader :it

def initialize it
  @it = it
  check
end

# Should set @ok to be true or false
def check
  @ok = self.class.check === it
end

def ok?
  @ok
end
