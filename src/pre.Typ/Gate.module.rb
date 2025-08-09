extend New
include Name
include DSLReaders

attr_reader :object, :error

def initialize object
  @object = object
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
