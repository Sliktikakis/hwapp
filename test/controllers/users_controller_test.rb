require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
  	@user = users(:exuser)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: @user
    assert_response :success
  end

end
