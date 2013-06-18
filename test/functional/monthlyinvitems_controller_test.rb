require 'test_helper'

class MonthlyinvitemsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:monthlyinvitems)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_monthlyinvitem
    assert_difference('Monthlyinvitem.count') do
      post :create, :monthlyinvitem => { }
    end

    assert_redirected_to monthlyinvitem_path(assigns(:monthlyinvitem))
  end

  def test_should_show_monthlyinvitem
    get :show, :id => monthlyinvitems(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => monthlyinvitems(:one).id
    assert_response :success
  end

  def test_should_update_monthlyinvitem
    put :update, :id => monthlyinvitems(:one).id, :monthlyinvitem => { }
    assert_redirected_to monthlyinvitem_path(assigns(:monthlyinvitem))
  end

  def test_should_destroy_monthlyinvitem
    assert_difference('Monthlyinvitem.count', -1) do
      delete :destroy, :id => monthlyinvitems(:one).id
    end

    assert_redirected_to monthlyinvitems_path
  end
end
