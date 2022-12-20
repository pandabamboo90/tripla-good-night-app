require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "SHOULD NOT save User without name" do
    link = User.new

    assert_not link.save
  end
end
