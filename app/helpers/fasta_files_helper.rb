module FastaFilesHelper
  def fasta_form_column(record, input_name)
     file_field_tag input_name
 end
 
  def fasta_file_name_column(record)
     link_to record.fasta_file_name, record.fasta.url
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
end
