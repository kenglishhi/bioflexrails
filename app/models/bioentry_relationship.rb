class BioentryRelationship < ActiveRecord::Base
  belongs_to :subject_bioentry,    :class_name => 'BioEntry', :foreign_key => 'subject_bioentry_id'
  belongs_to :object_bioentry, :class_name => 'BioEntry', :foreign_key => 'object_bioentry_id'
  belongs_to :term

end
