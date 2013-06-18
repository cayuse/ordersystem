require 'test_helper'

class WeeklydfcordersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:weeklydfcorders)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_weeklydfcorder
    assert_difference('Weeklydfcorder.count') do
      post :create, :weeklydfcorder => { }
    end

    assert_redirected_to weeklydfcorder_path(assigns(:weeklydfcorder))
  end

  def test_should_show_weeklydfcorder
    get :show, :id => weeklydfcorders(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => weeklydfcorders(:one).id
    assert_response :success
  end

  def test_should_update_weeklydfcorder
    put :update, :id => weeklydfcorders(:one).id, :weeklydfcorder => { }
    assert_redirected_to weeklydfcorder_path(assigns(:weeklydfcorder))
  end

  def test_should_destroy_weeklydfcorder
    assert_difference('Weeklydfcorder.count', -1) do
      delete :destroy, :id => weeklydfcorders(:one).id
    end

    assert_redirected_to weeklydfcorders_path
  end
end
