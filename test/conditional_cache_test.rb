require 'test_helper'

class ConditionalCache::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, ConditionalCache
  end
end
