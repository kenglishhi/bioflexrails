class Bioentry < ActiveRecord::Base
  #set
  belongs_to :biodatabase #, :class_name => "Biodatabase",:foreign_key =>"biodatabase_id"
  belongs_to :taxon #, :class_name => "Taxon",:foreign_key =>"taxon_id"
  has_one :biosequence, :dependent => :destroy
  has_one :fasta_file
  named_scope :sequence_in_database, lambda { |query_def, biodatabase_id|
    {:include => :biosequence,  :conditions=> ['name = ?  AND biodatabase_id = ? ',query_def, biodatabase_id]}
  } 


#  def self.load_fasta(fasta_file)
#    logger.error("[kenglish] load fasta file #{fasta_file.fasta.path}")
#    ff = Bio::FlatFile.open(Bio::FastaFormat, fasta_file.fasta.path )
#    biodatabase = Biodatabase.create(:name => File.basename(fasta_file.label))
#    ff.each do |entry|
#      bioentry = create(:biodatabase => biodatabase, :name => entry.definition, :accession => entry.definition, :version => 1)
#      Biosequence.create(:bioentry => bioentry, :seq => entry.seq, :version => 1, :alphabet => 'dna', :length => entry.seq.length)
#    end
#  end
  def to_fasta
    self.biosequence.to_fasta
  end
  def to_fasta_format
    self.biosequence.to_fasta_format
  end
end
