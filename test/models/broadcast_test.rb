require 'test_helper'

class BroadcastTest < ActiveSupport::TestCase
  test "number of users to retrieve" do
    assert Broadcast.per_page == 8
  end

  test "to_s method is defined" do
    assert defined? Broadcast.to_s
  end
end
