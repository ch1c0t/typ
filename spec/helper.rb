require 'typ'

require 'rspec/power_assert'
RSpec::PowerAssert.example_assertion_alias :assert
RSpec::PowerAssert.example_group_assertion_alias :assert

require 'timeout'

RSpec.configure do |config|
  config.around :each do |example|
    Timeout.timeout 5, &example
  end
end
