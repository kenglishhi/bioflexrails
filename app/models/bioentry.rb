class Bioentry < ActiveRecord::Base
  #set
  belongs_to :biodatabase #, :class_name => "Biodatabase",:foreign_key =>"biodatabase_id"
  belongs_to :taxon #, :class_name => "Taxon",:foreign_key =>"taxon_id"
  has_one :biosequence, :dependent => :destroy
  has_one :fasta_file

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
end
