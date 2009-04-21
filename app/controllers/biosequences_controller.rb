class BiosequencesController < ApplicationController
  active_scaffold :biosequences do |config|
     config.list.label = "Sequences"
     config.actions.exclude :nested
     config.list.columns = [:database_name, :name, :seq, :length, :alphabet, :version]
     config.show.columns = [ :bioentry, :entire_seq, :length,:alphabet, :version]     
     config.actions.exclude :nested , :create 
  end
end
