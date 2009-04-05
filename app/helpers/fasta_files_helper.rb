module FastaFilesHelper
  def fasta_form_column(record, input_name)
     file_field_tag input_name
 end
 
  def fasta_file_name_column(record)
     link_to record.fasta_file_name, record.fasta.url
 end
 def biodatabase_extract_column(record)
   if record.biodatabase
     "Extracted"
   else
      render  :partial => "/fasta_files/biodatabase_extract_link", :locals => {:record => record}
   end
 end
 
 def fasta_data_column(record)
     # Example 2 - Pass file to block
   output = ""
   File.open(record.fasta.path, "r") do |infile|
      while (line = infile.gets)
          output << line
     end
   end
   '<div id="fasta-data"><pre>' + output + '</pre></div>'
 end
  def db_colum(record)
     # Example 2 - Pass file to block
    link_to "Extract Sequences" if record.biodatabase.nil?
    "ALOHA"
 end
 
##   link_to_remote_with_spinner 'Hi', :url => hi_path, :container_id => 'container', :spinner => 'spinner' 
# def link_to_remote_with_spinner(title, options)
#  element_id = options.delete(:id) || ('link_to_' + title.underscore.tr(' ', '_'))
#  container_id = options.delete(:container_id) || element_id
##  
#  returning '' do |out|
##    unless spinner = options.delete(:spinner)
##      spinner = "#{element_id}_spinner"
##      out << image_tag('spinner.gif', :id => spinner, :style => 'display:none')
##    end
##    options[:complete] = "$('#{spinner}').hide(); " + (options[:complete] || "$('#{container_id}').show()")
##    
##    out << link_to_remote(title, { :loading => "$('#{container_id}').hide(); $('#{spinner}').show()" }.merge(options),
##                                 { :id => element_id })
##  end
#end


 
end
