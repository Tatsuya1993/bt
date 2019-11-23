require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end
  
  test "ログインしていない状態でユーザー一覧を取得しようとするとログインURLに飛ばされる" do
    get users_path
    assert_redirected_to login_url
  end
  
  test "サインアップページの取得" do
    get new_user_path
    assert_response :success
  end

  test "ユーザー設定においてログインしていない場合、ログインURLに飛ばされる" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ユーザー情報更新において、ログインしていない場合、ログインURLに飛ばされる" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "webで管理者権限を取得するパラーメータ送信しても管理者にはならない" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                    user: { password:              @other_user.password,
                                            password_confirmation: @other_user.password,
                                            admin: true } }
    assert_not @other_user.reload.admin?
  end

  test "誤ったユーザー(@other_user)で、ユーザー（@user)のアカウント設定ページを取得しようとすると警告文と共にトップへ戻る" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "誤ったユーザー(@other_user)で、ユーザー（@user)のパラメーター を変更すると警告文と共にトップへ戻る" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "ユーザー削除時に未ログインであれば、ログイン画面へ飛ばされる。" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "管理者でなければ、ユーザー削除をすることはできない" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

end
