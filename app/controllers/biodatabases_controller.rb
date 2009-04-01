class BiodatabasesController < ApplicationController
  
  active_scaffold :biodatabases do |config|
     config.list.label = "Databases"
     config.list.columns = [:name, :authority, :description, :sequence_count ]
     config.actions.exclude :nested
  end
end
