
sequence_fasta = FastaFile.find_by_label("EST_Clade_A")
target_fasta  =  FastaFile.find_by_label("EST_Clade_C")
exit unless sequence_fasta && target_fasta
puts sequence_fasta.label
puts target_fasta.label

ontology = Ontology.find_by_name('Onotology 1') || Ontology.create(:name => 'Onotology 1')
term = Term.find_by_name('Term 1') || Term.create(:name => 'Term 1', :ontology => ontology)
BlastCommand.delete_all
blast_command = {   :identity=>"12",
        :query_fasta_file_id=>sequence_fasta.id,
        :evalue=>"0.0001",
        :db_fasta_file_id=>target_fasta.id,
        :score=>"2"}

  blast_command = BlastCommand.create(blast_command.merge(:term => term )  )
  puts "Running commands term.valid? : #{term.valid?},blast_command.valid? : #{blast_command.errors.inspect}  "
  term.save
  blast_command.save
  puts "Running commands"
  blast_command.run_command

puts "ALOHA!"
exit

#require 'bio'
require 'tempfile'

target_db.fasta_file.formatdb

command = " blastall -p blastn -i #{sequence_db.fasta_file.fasta.path} -d #{target_db.fasta_file.fasta.path} -e 0.0001 -b 20 -v 20 "  
puts command
tempfile = Tempfile.new('blastout')
tempfile.close(false)
command <<  "-o  #{tempfile.path} " 
system(*command)

 # After system(), error checks will be needed but skipped.
tempfile.open

ff = Bio::FlatFile.open(tempfile)

ff.each do |report|
  # For example, prints query_def and target_def
  report.each do |hit|
  
    print report.query_def, "\t", hit.target_def, "\n"
    
  end
end
ff.close
tempfile.close(true)
