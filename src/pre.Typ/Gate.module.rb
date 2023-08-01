extend New
include DSLReaders

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
