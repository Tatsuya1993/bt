require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "サインアップページの取得" do
    get new_user_path
    assert_response :success
  end

end
