require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "サインアップページの取得" do
    get '/signup'
    assert_response :success
  end

end
