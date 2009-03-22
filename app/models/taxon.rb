class Taxon < ActiveRecord::Base
        has_one :bioentry
end
