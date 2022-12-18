require "test_helper"

class SleepRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sleep_record = sleep_records(:one)
  end

  test "should get index" do
    get sleep_records_url, as: :json
    assert_response :success
  end

  test "should create sleep_record" do
    assert_difference("SleepRecord.count") do
      post sleep_records_url, params: { sleep_record: { hours: @sleep_record.hours, length_in_seconds: @sleep_record.length_in_seconds, minutes: @sleep_record.minutes, seconds: @sleep_record.seconds, user_id: @sleep_record.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show sleep_record" do
    get sleep_record_url(@sleep_record), as: :json
    assert_response :success
  end

  test "should update sleep_record" do
    patch sleep_record_url(@sleep_record), params: { sleep_record: { hours: @sleep_record.hours, length_in_seconds: @sleep_record.length_in_seconds, minutes: @sleep_record.minutes, seconds: @sleep_record.seconds, user_id: @sleep_record.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy sleep_record" do
    assert_difference("SleepRecord.count", -1) do
      delete sleep_record_url(@sleep_record), as: :json
    end

    assert_response :no_content
  end
end
