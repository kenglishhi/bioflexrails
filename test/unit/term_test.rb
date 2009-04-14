require File.dirname(__FILE__) + '/../test_helper'

class TermTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  should_have_many :bioentry_relationships , :blast_commands
  should_belong_to :ontology 
  should_validate_presence_of :name
  should_validate_presence_of :ontology_id

end
