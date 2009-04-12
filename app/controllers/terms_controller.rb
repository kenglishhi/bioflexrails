class TermsController < ApplicationController
  active_scaffold :terms do |config|
     config.list.label = "Terms"
     config.actions.exclude :nested
     config.list.columns = [:name, :ontology, :is_obsolete, :identifier, :definition, :bioentry_relationships_count]
     config.create.columns =[:name, :ontology, :is_obsolete, :identifier, :definition] 
     config.update.columns =[:name, :ontology, :is_obsolete, :identifier, :definition] 
#     config.actions.exclude :nested
  end

end
