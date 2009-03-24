class FastaFilesController < ApplicationController
  active_scaffold :fasta_files do |config| 
    config.theme = :blue 
    config.list.columns = [:label, :fasta_file_name, :fasta_content_type, :fasta_file_size ]
    config.create.multipart = true
    config.create.columns = [:label, :fasta] 
    config.update.columns = [:label] 
    config.action_links.add "Blast", :parameters => {:controller => 'blast'},
                             :action => 'index', :type => :table, :page => true
  end

end 
