require 'test_helper'

class FoodvendorsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:foodvendors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create foodvendor" do
    assert_difference('Foodvendor.count') do
      post :create, :foodvendor => { }
    end

    assert_redirected_to foodvendor_path(assigns(:foodvendor))
  end

  test "should show foodvendor" do
    get :show, :id => foodvendors(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => foodvendors(:one).to_param
    assert_response :success
  end

  test "should update foodvendor" do
    put :update, :id => foodvendors(:one).to_param, :foodvendor => { }
    assert_redirected_to foodvendor_path(assigns(:foodvendor))
  end

  test "should destroy foodvendor" do
    assert_difference('Foodvendor.count', -1) do
      delete :destroy, :id => foodvendors(:one).to_param
    end

    assert_redirected_to foodvendors_path
  end
end
