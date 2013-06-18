require 'test_helper'

class WorksheetsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:worksheets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create worksheet" do
    assert_difference('Worksheet.count') do
      post :create, :worksheet => { }
    end

    assert_redirected_to worksheet_path(assigns(:worksheet))
  end

  test "should show worksheet" do
    get :show, :id => worksheets(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => worksheets(:one).to_param
    assert_response :success
  end

  test "should update worksheet" do
    put :update, :id => worksheets(:one).to_param, :worksheet => { }
    assert_redirected_to worksheet_path(assigns(:worksheet))
  end

  test "should destroy worksheet" do
    assert_difference('Worksheet.count', -1) do
      delete :destroy, :id => worksheets(:one).to_param
    end

    assert_redirected_to worksheets_path
  end
end
