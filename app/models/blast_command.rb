class BlastCommand < ActiveRecord::Base
  has_attached_file :output 

  belongs_to :term
  belongs_to :query_fasta_file,    :class_name => 'FastaFile', :foreign_key => 'query_fasta_file_id'
  belongs_to :db_fasta_file, :class_name => 'FastaFile', :foreign_key => 'db_fasta_file_id'

  validates_presence_of :query_fasta_file_id
  validates_presence_of :db_fasta_file_id
  validates_presence_of :evalue
  validates_presence_of :term_id
  attr_accessor :matches
  attr_accessor :number_of_fastas
  
#  def run_command
#    options={}
#    options[:evalue] = self.evalue || 0.001
#    db_biodatabase.fasta_file.formatdb
#    start_time = Time.now
#    command = " blastall -p blastn -i #{query_biodatabase.fasta_file.fasta.path} -d #{db_biodatabase.fasta_file.fasta.path} -e #{options[:evalue]}  -b 20 -v 20 "
#    tempfile = Tempfile.new('blastout')
#    tempfile.close(false)
#    command <<  "-o  #{tempfile.path} "
#    logger.error( "[kenglish] command = #{command} " )
#    system(*command)
#    tempfile.open
#
#    BioentryRelationship.delete_all(['term_id = ?' , term.id])
#    ff = Bio::FlatFile.open(tempfile)
#    @matches =0
#    ff.each do |report|
#      subject_bioentry = Bioentry.find(:first,:include =>:biodatabase, :conditions=> ['bioentry.name = ?  AND biodatabase.name = ? ',report.query_def[0..39],query_biodatabase.name ])
#      report.each do |hit|
#        object_bioentry = Bioentry.find(:first,:include =>:biodatabase, :conditions=> ['bioentry.name = ?  AND biodatabase.name = ? ',hit.target_def[0..39],db_biodatabase.name ])
#        if  subject_bioentry && object_bioentry
#          BioentryRelationship.create(:term => term, :subject_bioentry => subject_bioentry, :object_bioentry => object_bioentry)
#          @matches = @matches + 1
#        else
#          puts "kenglish] ERR finding  subject_bioentry = #{subject_bioentry} [#{report.query_def[0..39]},#{query_biodatabase.name}]  or #{object_bioentry} [#{hit.target_def[0..39]},#{db_biodatabase.name}]"
#        end
#      end
#    end
#    ff.close
#    tempfile.close(true)
#    end_time = Time.now
#    puts "kenglish] BLAST #{query_biodatabase.name} #{db_biodatabase.name} took #{end_time - start_time } "
#  end
  def   run_command
    def match_sequence(query_def, ff)
      count=0
      begin
        sequence = ff.next_entry
        return unless sequence
        count =+ 1
      end  until query_def ==  sequence.definition
      sequence
    end
    options={}
    options[:evalue] = self.evalue || 0.001

    db_fasta_file.formatdb
    start_time = Time.now
    command = " blastall -p blastn -i #{query_fasta_file.fasta.path} -d #{db_fasta_file.fasta.path} -e #{options[:evalue]}  -b 20 -v 20 "
    tempfile = Tempfile.new('blastout')
    tempfile.close(false)
    command <<  "-o  #{tempfile.path} "
    puts "[kenglish] tempfile.path = #{tempfile.path} " 
    puts "[kenglish]--------------------- "
    puts "[kenglish] command = #{command} "
    system(*command)
    tempfile.open
    result_ff = Bio::FlatFile.open(tempfile)
    db_ff = Bio::FlatFile.auto(db_fasta_file.fasta.path)
    query_ff = Bio::FlatFile.auto(query_fasta_file.fasta.path)
    
    result_ff.each do |report|
      query_ff_entry = match_sequence(report.query_def,query_ff)
#      puts "------------- \nMATCHED query_ff_entry = #{query_ff_entry.definition}, report.query_def  = #{report.query_def}" if  query_ff_entry
#      puts "NO MATCHED query_ff_entry = #{report.query_def} " unless  query_ff_entry
      tempfile = nil
      report.each do |hit|
        unless tempfile
          filename =   query_ff_entry.definition[0..39] + ".fasta"
          tempfile = Tempfile.new(filename)
          tempfile.puts(query_ff_entry)
        end
        db_ff.rewind
        db_ff_entry =  match_sequence(hit.target_def,db_ff)
        tempfile.puts(db_ff_entry)
        puts hit.target_def
#        puts  "db_ff_entry #{db_ff_entry.definition} \n"
      end
      if tempfile
        fasta_file = FastaFile.new
        fasta_file.fasta = tempfile
        fasta_file.is_generated = true
        fasta_file.save
      end      
    end

  end


  def create_fastas
    if self.term
      fasta_groups = {}
      BioentryRelationship.find(:all, :conditions => ['term_id = ?', term.id], :order => 'subject_bioentry_id').each do | br |
        if fasta_groups[br.subject_bioentry.id]
          fasta_groups[br.subject_bioentry.id][:object_bioentries] << br.object_bioentry
        else
          fasta_groups[br.subject_bioentry.id] = {}
          fasta_groups[br.subject_bioentry.id][:subject_bioentry] = br.subject_bioentry
          fasta_groups[br.subject_bioentry.id][:object_bioentries] = [br.object_bioentry]
        end
      end
      @number_of_fastas = 0

      fasta_groups.each do |key, fasta_group|
        filename =   fasta_group[:subject_bioentry].name + ".fasta"
        tempfile = Tempfile.new(filename)
        tempfile.puts(fasta_group[:subject_bioentry].to_fasta)
        fasta_group[:object_bioentries].each do |  entry |
          unless  entry.name == fasta_group[:subject_bioentry].name
            tempfile.puts(entry.to_fasta)
          end
        end
#        tempfile.close(false)

        fasta_file = FastaFile.new
        fasta_file.fasta = tempfile
        fasta_file.is_generated = true
        fasta_file.save
        @number_of_fastas = @number_of_fastas + 1
        puts    "  #{tempfile.path} {ff.valid?}"
      #  fasta_grou
      end
    end
  end

end

