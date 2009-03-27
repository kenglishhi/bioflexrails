class Bioentry < ActiveRecord::Base

  #set
  belongs_to :biodatabase#, :class_name => "Biodatabase",:foreign_key =>"biodatabase_id"
	belongs_to :taxon#, :class_name => "Taxon",:foreign_key =>"taxon_id"
	has_one :biosequence
  
  
  def self.load_fasta(file)
    ff = Bio::FlatFile.open(Bio::FastaFormat, file )
    biodatabase = Biodatabase.create(:name => File.basename(file))
    ff.each do |entry|
      bioentry = create(:biodatabase => biodatabase, :name => entry.definition, :accession => entry.definition, :version => 1)
      Biosequence.create(:bioentry => bioentry, :seq => entry.seq, :version => 1, :alphabet => 'dna')
    end  
  end
end
