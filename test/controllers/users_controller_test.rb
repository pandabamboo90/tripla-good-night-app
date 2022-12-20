require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_user = users(:user_one)
  end

  test "should response list of Users" do
    get users_url, headers: { 'current-user-id': @current_user.id }, as: :json
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal(true, json_response.has_key?('data') && json_response["data"].is_a?(Array))
  end
end
