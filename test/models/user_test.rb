require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "セットアップユーザーは有効" do
    assert @user.valid?
  end
  
  test "ユーザーの名前は存在していない" do
    @user.name = "     "
    assert_not @user.valid?
  end
  
  test "ユーザーのemailは存在していない" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "ユーザーの名前は長すぎない" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "ユーザーのemailは長すぎない" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "有効なアドレスは有効" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "無効なアドレスは拒否される" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "アドレスは一意でなければならない" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "メールアドレスは小文字で変換され保存される" do
    # メールアドレスの小文字変換保存機能はmodels/user.rb
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "バスワードは存在しなければならない(ブランク無効)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "バスワードの●文字以上でなければならない" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "記憶ダイジェストを持たないユーザーは偽になる" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test "ユーザーが削除された場合には、トピックも削除される" do
    @user.save
    @user.topics.create!(title:"test", content: "Lorem ipsum")
    assert_difference 'Topic.count', -1 do
      @user.destroy
    end
  end
end
