require 'test_helper'

class SitetypesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:sitetypes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_sitetype
    assert_difference('Sitetype.count') do
      post :create, :sitetype => { }
    end

    assert_redirected_to sitetype_path(assigns(:sitetype))
  end

  def test_should_show_sitetype
    get :show, :id => sitetypes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => sitetypes(:one).id
    assert_response :success
  end

  def test_should_update_sitetype
    put :update, :id => sitetypes(:one).id, :sitetype => { }
    assert_redirected_to sitetype_path(assigns(:sitetype))
  end

  def test_should_destroy_sitetype
    assert_difference('Sitetype.count', -1) do
      delete :destroy, :id => sitetypes(:one).id
    end

    assert_redirected_to sitetypes_path
  end
end
