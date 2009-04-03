require File.dirname(__FILE__) + '/../test_helper'

class TermTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  should_have_many :bioentry_relationships 
  should_belong_to :ontology 
end
