require 'test_helper'

class UsagesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:usages)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_usage
    assert_difference('Usage.count') do
      post :create, :usage => { }
    end

    assert_redirected_to usage_path(assigns(:usage))
  end

  def test_should_show_usage
    get :show, :id => usages(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => usages(:one).id
    assert_response :success
  end

  def test_should_update_usage
    put :update, :id => usages(:one).id, :usage => { }
    assert_redirected_to usage_path(assigns(:usage))
  end

  def test_should_destroy_usage
    assert_difference('Usage.count', -1) do
      delete :destroy, :id => usages(:one).id
    end

    assert_redirected_to usages_path
  end
end
