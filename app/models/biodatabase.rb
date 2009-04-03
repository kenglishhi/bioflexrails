class Biodatabase < ActiveRecord::Base
  has_many :bioentries #,:class_name =>"Bioentry", :foreign_key => "biodatabase_id"
  has_one :fasta_file #,:class_name =>"Bioentry", :foreign_key => "biodatabase_id"
  validates_uniqueness_of :name
  def blast_against(db_biodatabase, term)
     db_biodatabase.fasta_file.formatdb 
     cmd_line_args = "" 
     factory = Bio::Blast.local('blastn', db_biodatabase.fasta_file.fasta.path, cmd_line_args ) 
     bioentries.each do | bioentry | 
       if  bioentry.biosequence
         report = factory.query(bioentry.biosequence.seq) 
         puts "seq  #{ bioentry.biosequence.seq } " 
         report.each do |hit|
           hit.each do |hsp|
             if hit.evalue < 0.0001
#                  s = Bio::Sequence::NA.new(hsp.hseq)
#            fasta_data << Bio::Sequence::NA.new(entry.seq).to_fasta
                  puts "HIT "
                  # TODO
                  BioentryRelationship.create(:term => term, :subject_bioentry => bioentry, :object_bioentry => bioentry) 
             else
                puts "evalue too big #{hit.evalue}"
             end
           end
         end
       end 
     end
  end
end
