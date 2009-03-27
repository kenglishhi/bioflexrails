require 'stringio'
 require 'base64' 

class Biosequence < ActiveRecord::Base
  set_primary_key :bioentry_id
  belongs_to :bioentry


  def self.draw_graphic(value)
      #get the name and length of the main feature to be drawn
     main_feature = Bioentry.find(value)
     len = main_feature.biosequence.length.to_i
     name = main_feature.name
   
    #create a Biographics panel and add a track
      @my_panel = Bio::Graphics::Panel.new(len, :width=> 900)
      @track = @my_panel.add_track("#{name}",:glyph=>'directed_generic')

     m_feature_range = "1..#{len}"
      @track.add_feature(Bio::Feature.new("#{name}",m_feature_range), :label=>" ")

    #write the output to memory
        output = StringIO.new
        @my_panel.draw(output)
        return output.string
  end
  def self.load_fasta(file)
    ff = Bio::FlatFile.open(Bio::FastaFormat, file )

    ff.each do |entry|
#      self.create(:seq => :version: nil, length: nil, alphabet: nil, >)
      
    end  
  end
end
