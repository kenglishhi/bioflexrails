
sequence_db  = Biodatabase.find_by_name("EST_Clade_A")
target_db  = Biodatabase.find_by_name("EST_Clade_C")
exit unless sequence_db && target_db
puts sequence_db.name
puts target_db.name

Term.delete_all
BioentryRelationship.delete_all
Ontology.delete_all
ontology = Ontology.create(:name => 'Onotology 1')
term = Term.create(:name => 'Term 1', :ontology => ontology ) 

sequence_db.blast_against(target_db,term,{:evalue => 0.0001, :identity => 18})
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
