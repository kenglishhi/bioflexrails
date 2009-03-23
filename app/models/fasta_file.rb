class FastaFile < ActiveRecord::Base
   has_attached_file :fasta , :styles => { :fastadb => { :quality => :better } },
             :processors => [:formatdb] 
end
