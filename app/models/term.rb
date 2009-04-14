class Term < ActiveRecord::Base
  has_many :bioentry_relationships
  has_many :blast_commands
  belongs_to :ontology 
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :ontology_id
end
