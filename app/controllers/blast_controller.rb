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
    term_name = params[:term_name] 
#    db_id = FastaFile.find( params[:database_file_id] ) 
    query_biodatabase.blast_against(db_biodatabase) 
    blastn_2_files(query_biodatabase.fasta_file.fasta.path, db_biodatabase.fasta_file.fasta.path)
    redirect_to :controller => 'fasta_files',:action =>'index'
  end
  
end
