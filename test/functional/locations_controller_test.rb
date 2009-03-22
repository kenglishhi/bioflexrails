require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:location)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_location
    assert_difference('Location.count') do
      post :create, :location => { }
    end

    assert_redirected_to location_path(assigns(:location))
  end

  def test_should_show_location
    get :show, :id => location(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => location(:one).id
    assert_response :success
  end

  def test_should_update_location
    put :update, :id => location(:one).id, :location => { }
    assert_redirected_to location_path(assigns(:location))
  end

  def test_should_destroy_location
    assert_difference('Location.count', -1) do
      delete :destroy, :id => location(:one).id
    end

    assert_redirected_to location_path
  end
end
