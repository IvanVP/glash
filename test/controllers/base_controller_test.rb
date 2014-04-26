require 'test_helper'

class BaseControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get default" do
    get :default
    assert_response :success
  end

end
