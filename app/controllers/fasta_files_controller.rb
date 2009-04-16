class FastaFilesController < ApplicationController
  before_filter :login_required

  active_scaffold :fasta_files do |config| 
    
    config.list.label = "Fasta Files"
    config.list.columns = [:label, :fasta_file_name, :fasta_content_type, :fasta_file_size, :biodatabase_extract ]
    config.create.multipart = true
    config.create.columns = [:label, :fasta, ] 
    config.update.columns = [:label] 
    config.show.columns = [:label, :fasta_file_name, :fasta_file_size,:created_at,:fasta_data]
    config.action_links.add "Upload Files", :action => 'upload_many', :type => :table, :page => true
    config.actions.exclude :create
#    config.action_links.add "Blast", :parameters => {:controller => 'blast'},
#    :action => 'index', :type => :table, :page => true
    
  end
  def upload_many
    if request.post?
      logger.error("[kenglish] upload_many -- ")
      params[:fasta_files].each do | image_param |
        unless image_param[:uploaded_data].blank?
          fasta_file = FastaFile.new
          logger.error("[kenglish] uploaded data is #{image_param[:uploaded_data].inspect}")
          fasta_file.fasta = image_param[:uploaded_data]
          fasta_file.is_generated = false
          fasta_file.save
        end
      end
      redirect_to :action => :index
    end
  end
  
  def extract_sequences
    fasta_file = FastaFile.find(params[:id])
    fasta_file.extract_sequences
    render :inline => 'Extracted'    
  end
  
  
end 
