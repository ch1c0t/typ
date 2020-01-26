def self.new
  c = Class.new
  c.include Gate
  c
end

attr_reader :it, :error

def initialize it
  @it = it
  @ok = begin
          check
        rescue => e
          @error = e
          false
        end
end

def check
end

def ok?
  @ok
end
