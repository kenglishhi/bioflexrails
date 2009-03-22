class Seqfeature < ActiveRecord::Base
  belongs_to :bioentry
  has_many :locations
end
