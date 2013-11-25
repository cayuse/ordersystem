require 'test_helper'

class TrackCalendarsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:track_calendars)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_track_calendar
    assert_difference('TrackCalendar.count') do
      post :create, :track_calendar => { }
    end

    assert_redirected_to track_calendar_path(assigns(:track_calendar))
  end

  def test_should_show_track_calendar
    get :show, :id => track_calendars(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => track_calendars(:one).id
    assert_response :success
  end

  def test_should_update_track_calendar
    put :update, :id => track_calendars(:one).id, :track_calendar => { }
    assert_redirected_to track_calendar_path(assigns(:track_calendar))
  end

  def test_should_destroy_track_calendar
    assert_difference('TrackCalendar.count', -1) do
      delete :destroy, :id => track_calendars(:one).id
    end

    assert_redirected_to track_calendars_path
  end
end
