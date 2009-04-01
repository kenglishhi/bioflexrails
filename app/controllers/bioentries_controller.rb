class BioentriesController < ApplicationController
  active_scaffold :bioentries do |config| 
    config.list.label = "Entries"
    config.actions.exclude :nested
  end
end
