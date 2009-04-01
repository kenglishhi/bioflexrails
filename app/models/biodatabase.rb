class Biodatabase < ActiveRecord::Base
  has_many :bioentries #,:class_name =>"Bioentry", :foreign_key => "biodatabase_id"
  has_one :fasta_file #,:class_name =>"Bioentry", :foreign_key => "biodatabase_id"
  validates_uniqueness_of :name
  def blast_against(db_biodatabase)
     db_biodatabase.fasta_file.formatdb 
     
     

  end
end
