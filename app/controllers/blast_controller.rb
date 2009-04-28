class BlastController < ApplicationController
  include BioUtils
  before_filter :create_default_ontolgoy, :only => :index
  def index
#     @fasta_file_options = FastaFile.find(:all).map{ |f| [f.fasta_file_name,f.id] }  
     @blast_command = BlastCommand.new(:evalue => 0.0001 ) 
     @term = Term.new 
     
     @fasta_file_options =  FastaFile.find(:all,:order => 'label' ).map { |ff| [ff.label, ff.id ] }
     render :action => 'blast_form'
  end
  
  def blast
#    @term = Term.find_by_name("Default Term") || Term.create(:name => "Default Term" ) 

    @blast_command = BlastCommand.create(params[:blast_command]  )
    if @blast_command.valid?
#      @term.save
      @blast_command.save

    else 
      @fasta_file_options =  FastaFile.find(:all,:order => 'label' ).map { |ff| [ff.label, ff.id ] }
      render :action => 'blast_form'
    end
  end

  def run
    logger.error("[kenglish] called run" ) 
    blast_command = BlastCommand.find(params[:id] ) 
    blast_command.run_command

    render :json => {:result_url => url_for(:controller=> 'blast_commands', :action =>'index'),
             :matches =>blast_command.matches, :number_of_fastas =>blast_command.number_of_fastas,:output_file_url => blast_command.output.url}.to_json

  end

  private
  def create_default_ontolgoy
    if Ontology.count ==0
        Ontology.create(:name => 'Default Ontology')
    end
    Ontology.find(:all).map { |ont| [ont.name, ont.id] }
  end  
end
