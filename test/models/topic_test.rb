require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    # userに紐付いた新しいTopicオブジェクトを代入
    @topic = @user.topics.build(title:"test", content: "Lorem ipsum")
  end

  test "トピックは有効である" do
    assert @topic.valid?
  end

  test "トピックにuser_idが存在しなければいけない" do
    @topic.user_id = nil
    assert_not @topic.valid?
  end
  
  test "トピックにはコンテンツが存在する" do
    @topic.title= "  "
    @topic.content = "   "
    assert_not @topic.valid?
  end
  
  test "投稿されたトピックは最新順になる" do
    assert_equal topics(:most_recent), Topic.first
  end
end
