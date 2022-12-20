require "test_helper"

class SleepRecordTest < ActiveSupport::TestCase
  setup do
    @user_1 = users(:user_one)
  end

  test "SHOULD NOT save without [:started_at, :hours, :minutes, :seconds, :duration, :status]" do
    attrs = [:started_at, :hours, :minutes, :seconds, :duration, :status]

    record = SleepRecord.new
    record.user_id = @user_1.id

    record.started_at = nil
    record.hours = nil
    record.minutes = nil
    record.seconds = nil
    record.duration = nil
    record.status = nil

    assert_not record.save
    assert_equal(record.errors.full_messages.select { |msg| msg.include?("can't be blank") }.size, attrs.size)
  end

  test "SHOULD NOT save if one [:hours, :minutes, :seconds, :duration] attributes are not valid numbers" do
    attrs = [:hours, :minutes, :seconds, :duration]

    record = sleep_records(:one)
    record.hours = "a"
    record.minutes = -1
    record.seconds = 0.0
    record.duration = true

    assert_not record.save
    assert_equal(record.errors.full_messages.select { |msg| msg.include?("is not a number") }.size, 2)
    assert_equal(record.errors.full_messages.select { |msg| msg.include?("Minutes must be greater than or equal to 0") }.size, 1)
    assert_equal(record.errors.full_messages.select { |msg| msg.include?("Duration is not a number") }.size, 1)
  end
end
