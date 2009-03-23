class FastaFile < ActiveRecord::Base
  has_attached_file :fasta # , :styles => { :fastadb => { :quality => :better } },
    # :processors => [:formatdb]

  before_validation :set_label
  validates_uniqueness_of :label
  after_save :run_formatdb
  
  def set_label
    if self.label.blank?
      if fasta_file_name.match(/\.fasta$/)
        self.label= fasta_file_name.sub(/\.fasta$/,'')
        logger.error("[kenglish] setting lable  #{self.label}")
      end
    end
  end

  def run_formatdb
    if fasta and File.exists?(fasta.path)
      args = " -i #{fasta.path} -p F -o F -n #{fasta.path} " 
      puts "[kenglish] HELLO KEVIN  #{fasta.path} args = #{args}" 
      Paperclip.run "formatdb",  args
    end
  end
end
