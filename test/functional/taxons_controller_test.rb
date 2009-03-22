require 'test_helper'

class TaxonsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:taxon)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_taxon
    assert_difference('Taxon.count') do
      post :create, :taxon => { }
    end

    assert_redirected_to taxon_path(assigns(:taxon))
  end

  def test_should_show_taxon
    get :show, :id => taxon(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => taxon(:one).id
    assert_response :success
  end

  def test_should_update_taxon
    put :update, :id => taxon(:one).id, :taxon => { }
    assert_redirected_to taxon_path(assigns(:taxon))
  end

  def test_should_destroy_taxon
    assert_difference('Taxon.count', -1) do
      delete :destroy, :id => taxon(:one).id
    end

    assert_redirected_to taxon_path
  end
end
