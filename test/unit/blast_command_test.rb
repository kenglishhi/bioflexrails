require File.dirname(__FILE__) + '/../test_helper'


class BlastCommandTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  should_validate_presence_of :query_fasta_file_id,  :db_fasta_file_id, :evalue
  should_belong_to :term, :query_fasta_file, :db_fasta_file

  test "run command with small files" do

    sequence_fasta = fasta_file(:fasta_file_001)
    target_fasta  =  fasta_file(:fasta_file_003)
    assert File.exists?(sequence_fasta.fasta.path)
    assert File.exists?(target_fasta.fasta.path )
    ontology = ontology(:ontology_001)
    term = term(:term_001)

    blast_command_hash = {   :identity=>"12",
            :query_fasta_file_id=>sequence_fasta.id,
            :evalue=>"0.0001",
            :db_fasta_file_id=>target_fasta.id,
            :score=>"2",
            :fasta_file_prefix => 'my_fasta_1'}

    blast_command = BlastCommand.create(blast_command_hash.merge(:term => term )  )
    assert blast_command.valid?, "Should create blast command #{blast_command.errors.full_messages.to_sentence}"
    blast_command.reload

    old_blast_output_entry_count = BlastOutputEntry.count
    old_fasta_file_count = FastaFile.count
    blast_command.run_command
    assert_equal blast_command.output_file_name, "#{blast_command.fasta_file_prefix}_blast_output.txt"
    
#    assert_equal old_fasta_file_count, FastaFile.count, "Old count should equal new count."
#    assert old_blast_output_entry_count > BlastOutputEntry.count, "old_blast_output_entry_count (#{old_blast_output_entry_count}) should be > BlastOutputEntry.count (#{BlastOutputEntry.count})"
    blast_command.destroy
  end
  
  test "run command with big files" do
    sequence_fasta =  fasta_file(:fasta_file_001) 
    target_fasta =  create_big_fasta "EST_Clade_A.fasta"
    puts "Extracting sequences.."
    target_fasta
    assert File.exists?(sequence_fasta.fasta.path)
    assert File.exists?(target_fasta.fasta.path )
    
    ontology = ontology(:ontology_001)
    term = term(:term_001)

    blast_command_hash = {   :identity=>"12",
            :query_fasta_file_id=>sequence_fasta.id,
            :evalue=>"0.0001",
            :db_fasta_file_id=>target_fasta.id,
            :score=>"2",
            :fasta_file_prefix => 'my_fasta_1'}

    blast_command = BlastCommand.create(blast_command_hash.merge(:term => term )  )

    assert blast_command.valid?, "Should create blast command #{blast_command.errors.full_messages.to_sentence}"

    old_fasta_file_count = FastaFile.count
    blast_command.run_command
    blast_command.reload

    assert_equal blast_command.output_file_name, "#{blast_command.fasta_file_prefix}_blast_output.txt"
    puts blast_command.output.path    
    assert_not_nil   blast_command.output
    assert blast_command.output_file_name =~ /txt$/

    assert old_fasta_file_count <  FastaFile.count, "Old count should equal new count."
    FastaFile.find(:all, :conditions => 'fasta_file_id > 4').each do| fasta_file |
      assert fasta_file.destroy
    end
    blast_command.destroy
  end
  private
  def create_big_fasta(filename)
    tempfile = File.open(File.dirname(__FILE__) + "/../fixtures/files/#{filename}")
    sequence_fasta = FastaFile.new
    sequence_fasta.fasta = tempfile
    sequence_fasta.is_generated = false
    sequence_fasta.save
    sequence_fasta.extract_sequences
    sequence_fasta
  end


end

