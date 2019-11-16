require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "無効なユーザーパラメータが渡ると、ユーザー登録画面へ飛ぶ" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
  end
  
  test "有効なユーザーパラメーターが渡ると、ユーザー情報ページへ飛ぶ(ユーザーはログイン済）" do
    get new_user_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end