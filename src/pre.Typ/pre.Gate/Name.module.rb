attr_writer :name

def name
  @name ||= self.class.to_s
end
