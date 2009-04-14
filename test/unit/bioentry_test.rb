require File.dirname(__FILE__) + '/../test_helper'

class BioentryTest < ActiveSupport::TestCase
  # Replace this with your real tests.

  test "load fasta file" do
    prev_counts = {} 
    prev_counts[:bioentry] = Bioentry.count 
    prev_counts[:biosequence] = Biosequence.count 
    prev_counts[:biodatabase] = Biodatabase.count 

    file = File.dirname(__FILE__) + "/../fixtures/files/EST_Clade_A_5.fasta" 
#    FastaFile.new(
#    Bioentry.load_fasta file
#    assert_equal Bioentry.count, prev_counts[:bioentry]  + 5, "Should load five sequences into the db" 
#    assert_equal Biosequence.count, prev_counts[:biosequence] + 5 , "Should load five sequences into the db" 
#    assert_equal Biodatabase.count, prev_counts[:biodatabase] + 1, "Should load five sequences into the db" 

  end

end
