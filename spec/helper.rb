require 'typ'

require 'rspec/power_assert'
RSpec::PowerAssert.example_assertion_alias :assert
RSpec::PowerAssert.example_group_assertion_alias :assert

require_relative 'dsl'

RSpec.configure do |config|
  config.extend DSL
end
