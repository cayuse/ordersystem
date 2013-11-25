require 'test_helper'

class BidnamesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bidnames)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bidname" do
    assert_difference('Bidname.count') do
      post :create, :bidname => { }
    end

    assert_redirected_to bidname_path(assigns(:bidname))
  end

  test "should show bidname" do
    get :show, :id => bidnames(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => bidnames(:one).to_param
    assert_response :success
  end

  test "should update bidname" do
    put :update, :id => bidnames(:one).to_param, :bidname => { }
    assert_redirected_to bidname_path(assigns(:bidname))
  end

  test "should destroy bidname" do
    assert_difference('Bidname.count', -1) do
      delete :destroy, :id => bidnames(:one).to_param
    end

    assert_redirected_to bidnames_path
  end
end
