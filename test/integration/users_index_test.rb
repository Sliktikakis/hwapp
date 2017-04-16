require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:exuser)
  end

  test "index display" do
    get root_url
    assert_template 'users/index'
    assert_select 'div.search'
    assert_select 'canvas#mailchart'
    assert_select 'option', count: User.count+1
  end
end