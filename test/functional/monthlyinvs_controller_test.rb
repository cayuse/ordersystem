require 'test_helper'

class MonthlyinvsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:monthlyinvs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_monthlyinv
    assert_difference('Monthlyinv.count') do
      post :create, :monthlyinv => { }
    end

    assert_redirected_to monthlyinv_path(assigns(:monthlyinv))
  end

  def test_should_show_monthlyinv
    get :show, :id => monthlyinvs(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => monthlyinvs(:one).id
    assert_response :success
  end

  def test_should_update_monthlyinv
    put :update, :id => monthlyinvs(:one).id, :monthlyinv => { }
    assert_redirected_to monthlyinv_path(assigns(:monthlyinv))
  end

  def test_should_destroy_monthlyinv
    assert_difference('Monthlyinv.count', -1) do
      delete :destroy, :id => monthlyinvs(:one).id
    end

    assert_redirected_to monthlyinvs_path
  end
end
