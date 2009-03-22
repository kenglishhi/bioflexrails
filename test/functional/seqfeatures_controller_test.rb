require 'test_helper'

class SeqfeaturesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:seqfeature)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_seqfeature
    assert_difference('Seqfeature.count') do
      post :create, :seqfeature => { }
    end

    assert_redirected_to seqfeature_path(assigns(:seqfeature))
  end

  def test_should_show_seqfeature
    get :show, :id => seqfeature(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => seqfeature(:one).id
    assert_response :success
  end

  def test_should_update_seqfeature
    put :update, :id => seqfeature(:one).id, :seqfeature => { }
    assert_redirected_to seqfeature_path(assigns(:seqfeature))
  end

  def test_should_destroy_seqfeature
    assert_difference('Seqfeature.count', -1) do
      delete :destroy, :id => seqfeature(:one).id
    end

    assert_redirected_to seqfeature_path
  end
end
