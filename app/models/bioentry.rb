class Bioentry < ActiveRecord::Base

  #set
  belongs_to :biodatabase#, :class_name => "Biodatabase",:foreign_key =>"biodatabase_id"
	belongs_to :taxon#, :class_name => "Taxon",:foreign_key =>"taxon_id"
	has_one :biosequence
  
end
