class FastaFile < ActiveRecord::Base
  has_attached_file :fasta # , :styles => { :fastadb => { :quality => :better } },
    # :processors => [:formatdb]

  before_validation :set_label
  validates_uniqueness_of :label
  before_destroy :remove_fasta_dbs
  after_save :run_formatdb
  after_create :extract_sequences
  
  def set_label
    if self.label.blank?
      if fasta_file_name.match(/\.fasta$/)
        self.label= fasta_file_name.sub(/\.fasta$/,'')
        logger.error("[kenglish] setting label  #{self.label}")
      end
    end
  end

  def run_formatdb
    if fasta and File.exists?(fasta.path)
      args = " -i #{fasta.path} -p F -o F -n #{fasta.path} " 
      puts "[kenglish] HELLO KEVIN  #{fasta.path} args = #{args}" 
      Paperclip.run "formatdb",  args
      Bioentry.load_fasta fasta.path
    end
  end
  def remove_fasta_dbs
    File.delete(fasta.path + ".nhr", fasta.path + ".nsq", fasta.path + ".nil")
  end
  def extract_sequences
    if fasta and File.exists?(fasta.path)
      Bioentry.load_fasta fasta.path
    end
#    Bioentry.load_fasta fasta.path
  end
end
