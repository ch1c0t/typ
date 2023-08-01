def new
  c = Class.new
  c.include Gate
  c.extend Singleton
  c
end

