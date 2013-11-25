require 'test_helper'

class ItemtypesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:itemtypes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_itemtype
    assert_difference('Itemtype.count') do
      post :create, :itemtype => { }
    end

    assert_redirected_to itemtype_path(assigns(:itemtype))
  end

  def test_should_show_itemtype
    get :show, :id => itemtypes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => itemtypes(:one).id
    assert_response :success
  end

  def test_should_update_itemtype
    put :update, :id => itemtypes(:one).id, :itemtype => { }
    assert_redirected_to itemtype_path(assigns(:itemtype))
  end

  def test_should_destroy_itemtype
    assert_difference('Itemtype.count', -1) do
      delete :destroy, :id => itemtypes(:one).id
    end

    assert_redirected_to itemtypes_path
  end
end
