require File.dirname(__FILE__) + '/../test_helper'


class BlastCommandTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  should_validate_presence_of :query_fasta_file_id, :term_id, :db_fasta_file_id, :evalue
  should_belong_to :term, :query_fasta_file, :db_fasta_file
  


  test "run command with files only" do

    sequence_fasta = FastaFile.find_by_label("EST_Clade_A_6")
    target_fasta  =  FastaFile.find_by_label("EST_Clade_C_6")
    
    puts sequence_fasta.fasta.path
    puts target_fasta.fasta.path

#ontology = Ontology.find_by_name('Onotology 1') || Ontology.create(:name => 'Onotology 1')
#term = Term.find_by_name('Term 1') || Term.create(:name => 'Term 1', :ontology => ontology)
#BlastCommand.delete_all
#blast_command = {   :identity=>"12",
#        :query_fasta_file_id=>sequence_fasta.id,
#        :evalue=>"0.0001",
#        :db_fasta_file_id=>target_fasta.id,
#        :score=>"2"}
#
#  blast_command = BlastCommand.create(blast_command.merge(:term => term )  )
#  puts "Running commands term.valid? : #{term.valid?},blast_command.valid? : #{blast_command.errors.inspect}  "
#  term.save
#  blast_command.save
#  puts "Running commands"
#  blast_command.run_command
#
#puts "ALOHA!"
#exit


    assert false
  end


end

