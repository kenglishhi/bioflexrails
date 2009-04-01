module BiodatabasesHelper
  def sequence_count_column(record)
    record.bioentries.size
  end
end
