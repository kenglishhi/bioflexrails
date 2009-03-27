require File.dirname(__FILE__) + '/../test_helper'

class BiosequenceTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_truth
    assert true
  end
  test "load fasta file" do
    old_count = Biosequence.count 
    file = File.dirname(__FILE__) "/../fixtures/files/EST_Clade_A_5.fasta" 
    Biosequence.load_fasta file
    assert_equal Biosequence.count, old_count + 5, "Should load five sequences into the db" 
     
  end
end
