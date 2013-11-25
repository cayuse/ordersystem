require 'test_helper'

class StorelocsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:storelocs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create storeloc" do
    assert_difference('Storeloc.count') do
      post :create, :storeloc => { }
    end

    assert_redirected_to storeloc_path(assigns(:storeloc))
  end

  test "should show storeloc" do
    get :show, :id => storelocs(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => storelocs(:one).id
    assert_response :success
  end

  test "should update storeloc" do
    put :update, :id => storelocs(:one).id, :storeloc => { }
    assert_redirected_to storeloc_path(assigns(:storeloc))
  end

  test "should destroy storeloc" do
    assert_difference('Storeloc.count', -1) do
      delete :destroy, :id => storelocs(:one).id
    end

    assert_redirected_to storelocs_path
  end
end
