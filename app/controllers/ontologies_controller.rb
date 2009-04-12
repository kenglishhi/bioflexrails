class OntologiesController < ApplicationController
  active_scaffold :ontologies do |config|
     config.list.label = "Ontolory"
     config.list.columns = [:name,:definition,:terms] 
     config.create.columns = [:name,:definition] 
     config.update.columns = [:name,:definition] 
#     config.actions.exclude :nested
#     k
#     config.list.columns = [:name, :ontology, :is_obsolete, :identifier, :definition, :bioentry_relationships_count]
#     config.actions.exclude :nested
       end
#
end
