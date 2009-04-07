class BioentryRelationshipsController < ApplicationController
  active_scaffold :bioentry_relationships do |config| 
    config.list.label = "Relationships"
     config.list.columns = [:term, :subject_bioentry,:object_bioentry]
    config.actions.exclude :nested
  end

end
