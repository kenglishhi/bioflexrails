require File.dirname(__FILE__) + '/../test_helper'

class BiodatabaseTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :biodatabase, :ontology
  should_have_many :bioentries
  should_have_one :fasta_file
  should_validate_uniqueness_of :name 


end
