require File.dirname(__FILE__) + '/../test_helper'

class BiodatabaseTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :biodatabase, :ontology
  should_have_many :bioentries
  should_have_one :fasta_file
  should_validate_uniqueness_of :name 

  test "blast against another database" do
     biodatabase1 = biodatabase(:biodatabase_EST_Clade_A_3) 
     biodatabase2 = biodatabase(:biodatabase_EST_Clade_A_1) 
     term = Term.create(:name => 'Term 1', :ontology => ontology(:ontology_001) ) 
     assert term.valid?
     biodatabase1.blast_against(biodatabase2,term) 
     assert false
  end

end
