class Biodatabase < ActiveRecord::Base
  has_many :bioentries, :dependent => :destroy
  has_one :fasta_file #,:class_name =>"Bioentry", :foreign_key => "biodatabase_id"
  validates_uniqueness_of :name

  def load_fasta
    logger.error("[kenglish] load fasta file #{fasta_file.fasta.path}")
    ff = Bio::FlatFile.open(Bio::FastaFormat, fasta_file.fasta.path )
    ff.each do |entry|
      Bioentry.transaction do
        bioentry = Bioentry.create(:biodatabase => self, :name => entry.definition, :accession => entry.definition, :version => 1)
        Biosequence.create(:bioentry => bioentry, :seq => entry.seq, :version => 1, :alphabet => 'dna', :length => entry.seq.length)
      end
    end
  end    
  

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
  
  def blast_against_file2(db_biodatabase, term, options)
    require 'pp'
    db_biodatabase.fasta_file.formatdb 
    cmd_line_args = "" 
    factory = Bio::Blast.local('blastn', db_biodatabase.fasta_file.fasta.path, cmd_line_args )
    fasta = Bio::FlatFile.open(Bio::FastaFormat, self.fasta_file.fasta.path )
    
    fasta.each do |entry|
      report = factory.query(entry)
      
      report.each do |hit|
        debugger
          if hit.evalue < options[:evalue] # && hit.identity == options[:identity] &&  hit.score == options[:score]
            subject_bioentry = Bioentry.find(:first,:include =>:biodatabase, :conditions=> ['bioentry.name = ?  AND biodatabase.name = ? ',entry.definition,self.name ])
#            puts "subject_bioentry = #{subject_bioentry} "
            object_bioentry = Bioentry.find(:first,:include =>:biodatabase, :conditions=> ['bioentry.name = ?  AND biodatabase.name = ? ',hit.definition,db_biodatabase.name ])
#            puts object_bioentry.biosequence.seq
            BioentryRelationship.create(:term => term, :subject_bioentry => subject_bioentry, :object_bioentry => object_bioentry)
            puts "HIT:#{hit.definition} evalue:#{hit.evalue} class:#{hit.evalue.class}"
          else
#            puts "evalue too big #{hit.evalue}"
          end
        end      
    end
  end
  
  def blast_against(db_biodatabase, term, options)
    options[:evalue] = 0.001 unless options[:evalue] 
    db_biodatabase.fasta_file.formatdb
    start_time = Time.now
    command = " blastall -p blastn -i #{self.fasta_file.fasta.path} -d #{db_biodatabase.fasta_file.fasta.path} -e #{options[:evalue]}  -b 20 -v 20 "
    puts command
    tempfile = Tempfile.new('blastout')
    tempfile.close(false)
    command <<  "-o  #{tempfile.path} " 
    system(*command)

     # After system(), error checks will be needed but skipped.
    tempfile.open

    ff = Bio::FlatFile.open(tempfile)

    ff.each do |report|
      # For example, prints query_def and target_def
      report.each do |hit|
        subject_bioentry = Bioentry.find(:first,:include =>:biodatabase, :conditions=> ['bioentry.name = ?  AND biodatabase.name = ? ',report.query_def[0..39],self.name ])
        object_bioentry = Bioentry.find(:first,:include =>:biodatabase, :conditions=> ['bioentry.name = ?  AND biodatabase.name = ? ',hit.target_def[0..39],db_biodatabase.name ])
        if  subject_bioentry && object_bioentry
          BioentryRelationship.create(:term => term, :subject_bioentry => subject_bioentry, :object_bioentry => object_bioentry)
        else 
          puts "ERR finding  subject_bioentry = #{subject_bioentry} [#{report.query_def[0..39]},#{self.name}]  or #{object_bioentry} [#{hit.target_def[0..39]},#{db_biodatabase.name}]" 
        end
    
      end
    end
    ff.close
    tempfile.close(true)
    end_time = Time.now
    puts "BLAST #{self.name} #{db_biodatabase.name} took #{end_time - start_time } " 
    
  end 
  
end
