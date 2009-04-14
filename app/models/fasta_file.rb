class FastaFile < ActiveRecord::Base
  has_attached_file :fasta # , :styles => { :fastadb => { :quality => :better } },
    # :processors => [:formatdb]
  belongs_to :biodatabase
  before_validation :set_label
  validates_uniqueness_of :label
  before_destroy :remove_fasta_dbs
  
  def set_label
    if self.label.blank?
      if fasta_file_name && fasta_file_name.match(/\.fasta$/)
        self.label= fasta_file_name.sub(/\.fasta$/,'')
        logger.error("[kenglish] setting label  #{self.label}")
      end
    end
  end
  
  def extract_sequences
    if self.fasta  # and File.exists?(fasta.path)
      Bioentry.load_fasta(self)
      self.biodatabase = Biodatabase.find_by_name(self.label)
      self.save
    end
#    Bioentry.load_fasta fasta.path
  end
  def formatdb
    puts "called formatdb fasta = #{fasta} File.exists?(fasta.path) = #{File.exists?(fasta.path)} " 
    if fasta and File.exists?(fasta.path)
      args = " -i #{fasta.path} -p F -o F -n #{fasta.path} " 
      puts "[kenglish] HELLO KEVIN  #{fasta.path} args = #{args}" 
      Paperclip.run "formatdb",  args
    end
  end
  def remove_fasta_dbs
    extensions = ["nhr", "nsq", "nil"]
    extensions.each do | extension |
      dbfile = "#{fasta.path}.#{extension}"
      File.delete dbfile  if File.exist? dbfile
    end

  end

end
