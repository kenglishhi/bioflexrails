module FastaFilesHelper
  def fasta_form_column(record, input_name)
     file_field_tag input_name
 end
 
  def fasta_file_name_column(record)
     link_to record.fasta_file_name, record.fasta.url
 end
 def biodatabase_column(record)
   if record.biodatabase
     link_to "Extracted"
   else 
     link_to "Extract Sequences", :action => 'extract_sequences', :id => record.id
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
 
 
end
