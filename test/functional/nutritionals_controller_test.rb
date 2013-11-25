require 'test_helper'

class NutritionalsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nutritionals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nutritional" do
    assert_difference('Nutritional.count') do
      post :create, :nutritional => { }
    end

    assert_redirected_to nutritional_path(assigns(:nutritional))
  end

  test "should show nutritional" do
    get :show, :id => nutritionals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => nutritionals(:one).to_param
    assert_response :success
  end

  test "should update nutritional" do
    put :update, :id => nutritionals(:one).to_param, :nutritional => { }
    assert_redirected_to nutritional_path(assigns(:nutritional))
  end

  test "should destroy nutritional" do
    assert_difference('Nutritional.count', -1) do
      delete :destroy, :id => nutritionals(:one).to_param
    end

    assert_redirected_to nutritionals_path
  end
end
