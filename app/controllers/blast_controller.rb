class BlastController < ApplicationController
  include BioUtils

  def index
#     @fasta_file_options = FastaFile.find(:all).map{ |f| [f.fasta_file_name,f.id] }  
     @biodatabase_options = Biodatabase.find(:all,:order => 'name' ).map { |biodb| [biodb.name, biodb.id ] }
     render :action => 'blast_form'
  end
  
  def blast
    query_biodatabase = Biodatabase.find( params[:query_biodatabase_id ] ) 
    db_biodatabase = Biodatabase.find( params[:db_biodatabase_id ] ) 
    ontology = Ontology.find(:first)
    term = Term.create(:name => params[:term_name] , :ontology => ontology ) 
    # :evalue => 1
#    db_id = FastaFile.find( params[:database_file_id] ) 
    query_biodatabase.blast_against(db_biodatabase, term, { :evalue => params[:evalue].to_f, :identity => params[:identity], :score => params[:score] }  ) 
    redirect_to :controller => 'bioentry_relationships',:action =>'index'
  end
  
end
