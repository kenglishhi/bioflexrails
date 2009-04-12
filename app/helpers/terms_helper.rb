module TermsHelper
  def bioentry_relationships_count_column(record)
    record.bioentry_relationships.size
  end

end
