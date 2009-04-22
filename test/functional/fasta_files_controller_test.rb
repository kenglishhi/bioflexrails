require File.dirname(__FILE__) + '/../test_helper'

class FastaFilesControllerTest < ActionController::TestCase
  # Replace this with your real tests. 
  test "upload file" do
    fdata = fixture_file_upload('/files/file1.fasta', 'text/plain')
    old_count = FastaFile.count

    post :create, :record => {:label => "FILE 1", :fasta => { :uploaded_data => fdata }}, :html => { :multipart => true }

    assert_response :redirect
    assert_equal  old_count+1, FastaFile.count 

  end
end
