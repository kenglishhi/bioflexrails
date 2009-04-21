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
  def entire_seq_column(record)
#    '<textarea style="border:1px solid red; width:100px;word-wrap:break-word;">AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA</textarea>'

    '<font face="Courier New, Courier, mono">' + wrap_text(record.seq)  + "</font>"
  end

  def wrap_text(txt, col = 50)
    txt.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/,
      "\\1\\3<br />\n")
  end


end
