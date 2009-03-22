class FastaFile < ActiveRecord::Base
   has_attached_file :fasta , :styles => { :text => { :quality => :better } },
             :processors => [:formatdb] 
end
