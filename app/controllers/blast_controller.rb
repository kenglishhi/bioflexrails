class BlastController < ApplicationController
  include BioUtils
  def index
     @fasta_file_options = FastaFile.find(:all).map{ |f| [f.fasta_file_name,f.id] }       
  end 
  def blast
    query_file = FastaFile.find( params[:query_file_id ] ) 
    database_file = FastaFile.find( params[:database_file_id] ) 
    blastn_2_files(query_file.fasta.path, database_file.fasta.path)
    redirect_to :controller => 'fasta_files',:action =>'index'
  end 
end
