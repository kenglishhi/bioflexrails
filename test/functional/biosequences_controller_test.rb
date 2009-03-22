require 'test_helper'

class BiosequencesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:biosequence)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_biosequence
    assert_difference('Biosequence.count') do
      post :create, :biosequence => { }
    end

    assert_redirected_to biosequence_path(assigns(:biosequence))
  end

  def test_should_show_biosequence
    get :show, :id => biosequence(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => biosequence(:one).id
    assert_response :success
  end

  def test_should_update_biosequence
    put :update, :id => biosequence(:one).id, :biosequence => { }
    assert_redirected_to biosequence_path(assigns(:biosequence))
  end

  def test_should_destroy_biosequence
    assert_difference('Biosequence.count', -1) do
      delete :destroy, :id => biosequence(:one).id
    end

    assert_redirected_to biosequence_path
  end
end
