require "test_helper"

class UserFollowerTest < ActiveSupport::TestCase

  setup do
    @user_1 = users(:user_one)
    @user_2 = users(:user_two)
    @user_3 = users(:user_three)
  end

  test "SHOULD NOT save without status" do
    record = UserFollower.new
    record.user_id = @user_1.id
    record.following_user_id = @user_3.id

    assert_not record.save
    assert_equal(record.errors.first.full_message, "Status can't be blank")
  end

  test "SHOULD NOT save if record duplicated" do
    record = UserFollower.new
    record.user_id = @user_1.id
    record.following_user_id = @user_2.id
    record.status = :following

    assert_not record.save
    assert_equal(record.errors.first.full_message, "User and Following User record already existed")
  end
end
