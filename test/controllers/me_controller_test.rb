require "test_helper"

class MeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_user = users(:user_one)
    @user_two = users(:user_two)
    @user_three = users(:user_three)
    @sleep_record_one = sleep_records(:one)
  end

  test "should add new Sleep Record and response list of Sleep Record ordered by 'created_at'" do
    prev_num_of_sleep_records = @current_user.sleep_records.size

    payload = { sleep_record: { started_at: Time.zone.now } }
    post '/me/sleep_records', headers: { 'current-user-id': @current_user.id }, params: payload, as: :json
    json_response = JSON.parse(response.body)

    assert_response :success
    assert json_response.has_key?('data')

    data = json_response["data"]
    assert data.is_a?(Array)
    assert_equal(data.size, prev_num_of_sleep_records + 1)
    assert data.first["created_at"] > data.second["created_at"]
  end

  test "should update an Sleep Record and return the updated record" do
    prev_num_of_sleep_records = @current_user.sleep_records.size

    payload = { sleep_record: { started_at: Time.zone.now, ended_at: Time.zone.now + 3.hours } }
    put "/me/sleep_records/#{@sleep_record_one.id}", headers: { 'current-user-id': @current_user.id }, params: payload, as: :json
    json_response = JSON.parse(response.body)

    assert_response :success
    assert json_response.has_key?('data')

    data = json_response["data"]
    assert_equal(@current_user.sleep_records.size, prev_num_of_sleep_records)
    assert_equal(data["id"], @sleep_record_one.id)
    assert_equal(data["status"], "ended")
  end

  test "should response list of Followers" do
    get '/me/followers', headers: { 'current-user-id': @current_user.id }, as: :json
    json_response = JSON.parse(response.body)

    assert_response :success
    assert json_response.has_key?('data')

    data = json_response["data"]
    assert data.is_a?(Array)
    assert_equal(data.size, 1)
  end

  test "should response list of Following Users" do
    get '/me/following_users', headers: { 'current-user-id': @current_user.id }, as: :json
    json_response = JSON.parse(response.body)

    assert_response :success
    assert json_response.has_key?('data')

    data = json_response["data"]
    assert data.is_a?(Array)
    assert_equal(data.size, 1)
  end

  test "should follow another User successfully" do
    prev_num_of_following_users = @current_user.following_users.size

    put '/me/follow/3', headers: { 'current-user-id': @current_user.id }, as: :json
    json_response = JSON.parse(response.body)

    assert_response :success
    assert json_response.has_key?('message')
    assert_equal(@current_user.following_users.size, prev_num_of_following_users + 1)
  end

  test "should unfollow another User successfully" do
    prev_num_of_following_users = @current_user.following_users.size

    put "/me/unfollow/#{@user_two.id}", headers: { 'current-user-id': @current_user.id }, as: :json
    json_response = JSON.parse(response.body)

    assert_response :success
    assert json_response.has_key?('message')
    assert_equal(@current_user.following_users.size, prev_num_of_following_users - 1)
  end

  test "should response an error message if you view Sleep Records of unfollowed User" do
    get "/me/followers/#{@user_two.id}/sleep_records", headers: { 'current-user-id': @current_user.id }, as: :json
    json_response = JSON.parse(response.body)

    assert_response :error
    assert json_response.has_key?('errors')

    errors = json_response['errors']
    assert errors.is_a?(Array)
    assert_equal(errors.first['detail'], 'you are not allowed to view sleep records of this Follower because they are not following you')
  end

  test "should response list of Sleep Records of Follower" do
    get "/me/followers/#{@user_three.id}/sleep_records", headers: { 'current-user-id': @current_user.id }, as: :json
    json_response = JSON.parse(response.body)

    assert_response :success
    assert json_response.has_key?('data')

    data = json_response["data"]
    assert data.is_a?(Array)
    assert_equal(data.size, 1)
    assert_equal(data.first["user_id"], @user_three.id)
  end
end
