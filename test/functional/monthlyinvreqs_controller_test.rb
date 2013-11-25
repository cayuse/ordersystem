require 'test_helper'

class MonthlyinvreqsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:monthlyinvreqs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_monthlyinvreq
    assert_difference('Monthlyinvreq.count') do
      post :create, :monthlyinvreq => { }
    end

    assert_redirected_to monthlyinvreq_path(assigns(:monthlyinvreq))
  end

  def test_should_show_monthlyinvreq
    get :show, :id => monthlyinvreqs(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => monthlyinvreqs(:one).id
    assert_response :success
  end

  def test_should_update_monthlyinvreq
    put :update, :id => monthlyinvreqs(:one).id, :monthlyinvreq => { }
    assert_redirected_to monthlyinvreq_path(assigns(:monthlyinvreq))
  end

  def test_should_destroy_monthlyinvreq
    assert_difference('Monthlyinvreq.count', -1) do
      delete :destroy, :id => monthlyinvreqs(:one).id
    end

    assert_redirected_to monthlyinvreqs_path
  end
end
