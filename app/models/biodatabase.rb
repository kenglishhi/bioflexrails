class Biodatabase < ActiveRecord::Base
  has_many :bioentries #,:class_name =>"Bioentry", :foreign_key => "biodatabase_id"
  validates_uniqueness_of :name
end
