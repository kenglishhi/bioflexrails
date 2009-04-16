module BiosequencesHelper

  def render_image(feature_obj)
     image_tag(url_for({:action=>'to_image',:id=>feature_obj}))
  end
  def database_name_column(record)
    record.bioentry ? record.bioentry.biodatabase.name : "YO"
  end
  def name_column(record)
    record.bioentry ? record.name: "No Bio Entry"
  end
end
