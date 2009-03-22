require 'test_helper'

class BiodatabasesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:biodatabase)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_biodatabase
    assert_difference('Biodatabase.count') do
      post :create, :biodatabase => { }
    end

    assert_redirected_to biodatabase_path(assigns(:biodatabase))
  end

  def test_should_show_biodatabase
    get :show, :id => biodatabase(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => biodatabase(:one).id
    assert_response :success
  end

  def test_should_update_biodatabase
    put :update, :id => biodatabase(:one).id, :biodatabase => { }
    assert_redirected_to biodatabase_path(assigns(:biodatabase))
  end

  def test_should_destroy_biodatabase
    assert_difference('Biodatabase.count', -1) do
      delete :destroy, :id => biodatabase(:one).id
    end

    assert_redirected_to biodatabase_path
  end
end
