class Biodatabase < ActiveRecord::Base
  has_many :bioentries #,:class_name =>"Bioentry", :foreign_key => "biodatabase_id"
  has_one :fasta_file #,:class_name =>"Bioentry", :foreign_key => "biodatabase_id"
  validates_uniqueness_of :name

  def blast_against_db(db_biodatabase, term, options)

    db_biodatabase.fasta_file.formatdb 
    cmd_line_args = "" 
    factory = Bio::Blast.local('blastn', db_biodatabase.fasta_file.fasta.path, cmd_line_args ) 
    bioentries.each do | bioentry |
#      bioentry = bioentries.first
      if  bioentry.biosequence
        report = factory.query(bioentry.biosequence.seq) 
        report.each do |hit|
          if hit.evalue < options[:evalue]
            object_bioentry = Bioentry.find(:first,:include =>:biodatabase, :conditions=> ['bioentry.name = ?  AND biodatabase.name = ? ',hit.definition,db_biodatabase.name ])
#            puts object_bioentry.biosequence.seq
            BioentryRelationship.create(:term => term, :subject_bioentry => bioentry, :object_bioentry => object_bioentry)
#            puts "HIT:#{hit.definition} evalue:#{hit.evalue} class:#{hit.evalue.class}"
          else
#            puts "evalue too big #{hit.evalue}"
          end
        end
      end 
    end
  end
  
  def blast_against(db_biodatabase, term, options)
    require 'pp'
    db_biodatabase.fasta_file.formatdb 
    cmd_line_args = "" 
    factory = Bio::Blast.local('blastn', db_biodatabase.fasta_file.fasta.path, cmd_line_args )
    fasta = Bio::FlatFile.open(Bio::FastaFormat, self.fasta_file.fasta.path )
    
    fasta.each do |entry|
      report = factory.query(entry)
      debugger
      
      report.each do |hit|
          if hit.evalue < options[:evalue]
            subject_bioentry = Bioentry.find(:first,:include =>:biodatabase, :conditions=> ['bioentry.name = ?  AND biodatabase.name = ? ',entry.definition,self.name ])
#            puts "subject_bioentry = #{subject_bioentry} "
            object_bioentry = Bioentry.find(:first,:include =>:biodatabase, :conditions=> ['bioentry.name = ?  AND biodatabase.name = ? ',hit.definition,db_biodatabase.name ])
#            puts object_bioentry.biosequence.seq
            BioentryRelationship.create(:term => term, :subject_bioentry => subject_bioentry, :object_bioentry => object_bioentry)
 #           puts "HIT:#{hit.definition} evalue:#{hit.evalue} class:#{hit.evalue.class}"
          else
#            puts "evalue too big #{hit.evalue}"
          end
        end      
      
      
    end
  end  
  
end
