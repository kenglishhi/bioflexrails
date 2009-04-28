class BlastOutputEntry < ActiveRecord::Base
  belongs_to :blast_command
  belongs_to :bioentry
end
