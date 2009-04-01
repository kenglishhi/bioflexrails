class BiosequencesController < ApplicationController
  active_scaffold :biosequences do |config|
     config.list.label = "Sequences"
     config.actions.exclude :nested
     
     config.list.columns = [:database_name, :name, :seq, :length, :alphabet, :version]
     config.actions.exclude :nested     
  end
end
