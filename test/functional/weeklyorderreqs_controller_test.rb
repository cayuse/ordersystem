require 'test_helper'

class WeeklyorderreqsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:weeklyorderreqs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_weeklyorderreq
    assert_difference('Weeklyorderreq.count') do
      post :create, :weeklyorderreq => { }
    end

    assert_redirected_to weeklyorderreq_path(assigns(:weeklyorderreq))
  end

  def test_should_show_weeklyorderreq
    get :show, :id => weeklyorderreqs(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => weeklyorderreqs(:one).id
    assert_response :success
  end

  def test_should_update_weeklyorderreq
    put :update, :id => weeklyorderreqs(:one).id, :weeklyorderreq => { }
    assert_redirected_to weeklyorderreq_path(assigns(:weeklyorderreq))
  end

  def test_should_destroy_weeklyorderreq
    assert_difference('Weeklyorderreq.count', -1) do
      delete :destroy, :id => weeklyorderreqs(:one).id
    end

    assert_redirected_to weeklyorderreqs_path
  end
end
