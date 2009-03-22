require 'test_helper'

class BioentriesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:bioentry)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_bioentry
    assert_difference('Bioentry.count') do
      post :create, :bioentry => { }
    end

    assert_redirected_to bioentry_path(assigns(:bioentry))
  end

  def test_should_show_bioentry
    get :show, :id => bioentry(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => bioentry(:one).id
    assert_response :success
  end

  def test_should_update_bioentry
    put :update, :id => bioentry(:one).id, :bioentry => { }
    assert_redirected_to bioentry_path(assigns(:bioentry))
  end

  def test_should_destroy_bioentry
    assert_difference('Bioentry.count', -1) do
      delete :destroy, :id => bioentry(:one).id
    end

    assert_redirected_to bioentry_path
  end
end
