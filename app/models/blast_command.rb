class BlastCommand < ActiveRecord::Base

  belongs_to :term

  belongs_to :query_biodatabase,    :class_name => 'Biodatabase', :foreign_key => 'query_biodatabase_id'
  belongs_to :db_biodatabase, :class_name => 'Biodatabase', :foreign_key => 'db_biodatabase_id'

  validates_presence_of :query_biodatabase_id
  validates_presence_of :db_biodatabase_id
  validates_presence_of :evalue
  validates_presence_of :term_id
  def run_command
    options={}
    options[:evalue] = self.evalue || 0.001 
    db_biodatabase.fasta_file.formatdb
    start_time = Time.now
    command = " blastall -p blastn -i #{query_biodatabase.fasta_file.fasta.path} -d #{db_biodatabase.fasta_file.fasta.path} -e #{options[:evalue]}  -b 20 -v 20 "
    tempfile = Tempfile.new('blastout')
    tempfile.close(false)
    command <<  "-o  #{tempfile.path} " 
    logger.error( "[kenglish] command = #{command} " ) 
    system(*command)
    tempfile.open

    BioentryRelationship.delete_all(['term_id = ?' , term.id]) 
    ff = Bio::FlatFile.open(tempfile)

    ff.each do |report|
      report.each do |hit|
        subject_bioentry = Bioentry.find(:first,:include =>:biodatabase, :conditions=> ['bioentry.name = ?  AND biodatabase.name = ? ',report.query_def[0..39],query_biodatabase.name ])
        object_bioentry = Bioentry.find(:first,:include =>:biodatabase, :conditions=> ['bioentry.name = ?  AND biodatabase.name = ? ',hit.target_def[0..39],db_biodatabase.name ])
        if  subject_bioentry && object_bioentry
          BioentryRelationship.create(:term => term, :subject_bioentry => subject_bioentry, :object_bioentry => object_bioentry)
        else 
          puts "kenglish] ERR finding  subject_bioentry = #{subject_bioentry} [#{report.query_def[0..39]},#{query_biodatabase.name}]  or #{object_bioentry} [#{hit.target_def[0..39]},#{db_biodatabase.name}]" 
        end
    
      end
    end
    ff.close
    tempfile.close(true)
    end_time = Time.now
    puts "kenglish] BLAST #{query_biodatabase.name} #{db_biodatabase.name} took #{end_time - start_time } " 

  end

end

