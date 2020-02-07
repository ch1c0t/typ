require 'helper'

describe '.key' do
  describe do
    typ do
      key 1, [:==, :some_symbol]
    end

    good_hash = { 1 => :some_symbol }
    good good_hash

    hash_with_different_symbol = { 1 => :another }
    bad hash_with_different_symbol

    hash_without_the_key = {}
    bad hash_without_the_key

    good [0, :some_symbol]
    bad [0, :another]
    bad []
  end
end
