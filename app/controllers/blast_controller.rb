class BlastController < ApplicationController
  include BioUtils
  before_filter :create_default_ontolgoy, :only => :index
  def index
#     @fasta_file_options = FastaFile.find(:all).map{ |f| [f.fasta_file_name,f.id] }  
     @blast_command = BlastCommand.new(:evalue => 0.0001 ) 
     @term = Term.new 
     @biodatabase_options = Biodatabase.find(:all,:order => 'name' ).map { |biodb| [biodb.name, biodb.id ] }
     render :action => 'blast_form'
  end
  
  def blast
    
    @term = Term.find_by_name(params[:term][:name]) || Term.create(params[:term] ) 

    @blast_command = BlastCommand.create(params[:blast_command].merge(:term => @term )  ) 
    if @term.valid? &&  @blast_command.valid? 
      @term.save
      @blast_command.save
    else 
      @biodatabase_options = Biodatabase.find(:all,:order => 'name' ).map { |biodb| [biodb.name, biodb.id ] }
      render :action => 'blast_form'
    end
  end

  def  run 
    logger.error("[kenglish] called run" ) 
    blast_command = BlastCommand.find(params[:id] ) 
    blast_command.run_command
    blast_command.create_fastas
    render :json => {:result_url => url_for(:controller=> 'bioentry_relationships', :action =>'index', :search => blast_command.term.name),
             :matches =>blast_command.matches, :number_of_fastas =>blast_command.number_of_fastas  }.to_json

  end
#    flash[:errors] = []
#      flash[:errors] << "Query File can not be blank."      
#    end
#    
#    if params[:db_biodatabase_id ].blank?
#      flash[:errors] << "Db File can not be blank."      
#    end
#    
#    if params[:term_name].blank?
#      flash[:errors] << "Term Name can not be blank."            
#    end
#    
#    unless flash[:errors].empty?
#    end
    
#    render :action => 'blast_form'
#    return
#    @biodatabase_options = Biodatabase.find(:all,:order => 'name' ).map { |biodb| [biodb.name, biodb.id ] }
    
    
#    query_biodatabase = Biodatabase.find( params[:query_biodatabase_id ] ) 
#    db_biodatabase = Biodatabase.find( params[:db_biodatabase_id ] )
    
#    ontology = Ontology.find(:first) || Ontology.create(:name => "Ontology 1" ) 
#    term = Term.create(:name => params[:term_name] , :ontology => ontology ) 
    # :evalue => 1
#    db_id = FastaFile.find( params[:database_file_id] ) 
#    query_biodatabase.blast_against(db_biodatabase, term, { :evalue => params[:evalue].to_f, :identity => params[:identity], :score => params[:score] }  ) 
#    redirect_to :controller => 'bioentry_relationships',:action =>'index'
#  end
  private
  def create_default_ontolgoy
    if Ontology.count ==0
        Ontology.create(:name => 'Default Ontology')
    end
    Ontology.find(:all).map { |ont| [ont.name, ont.id] }
  end  
end
