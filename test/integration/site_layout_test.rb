require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
   @user = users(:michael)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 1
  end
end