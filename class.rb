module Singleton
  attr_accessor :dsl_method, :dsl_literal
end

c = Class.new
c.extend Singleton

p c
p c.ancestors
c.dsl_method = :is
p c.dsl_method
