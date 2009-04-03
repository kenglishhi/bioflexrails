class Term < ActiveRecord::Base
  has_many :bioentry_relationships
  belongs_to :ontology
end
