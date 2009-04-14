require File.dirname(__FILE__) + '/../test_helper'


class BlastCommandTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  should_validate_presence_of :query_biodatabase_id, :term_id, :db_biodatabase_id
end
