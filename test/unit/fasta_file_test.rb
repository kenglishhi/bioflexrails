require File.dirname(__FILE__) + '/../test_helper'

class FastaFileTest < ActiveSupport::TestCase
  should_validate_uniqueness_of :label
  should_belong_to :biodatabase , :dependent => :destroy

  test "create fasta file" do
    filename =  "EST_Clade_A_5.fasta"
    tempfile = File.open(File.dirname(__FILE__) + "/../fixtures/files/#{filename}")

    fasta_file = FastaFile.new
    fasta_file.fasta = tempfile
    fasta_file.is_generated = true
    assert fasta_file.save, "Saving fasta file should succeed #{fasta_file.errors.full_messages.to_sentence}"
    assert File.exists?( fasta_file.fasta.path ), "File should exist after create"
    old_path = fasta_file.fasta.path
    fasta_file.destroy
    assert !File.exists?( old_path ), "File should be deleted after destroy"    
  end
  test "create fasta file fails" do
    filename = fasta_file(:fasta_file_001).fasta_file_name 
    tempfile = File.open(File.dirname(__FILE__) + "/../fixtures/files/#{filename}")

    fasta_file = FastaFile.new
    fasta_file.fasta = tempfile

    assert !fasta_file.valid?
    assert fasta_file.errors.full_messages.to_sentence =~ /Label has already been taken/
    assert !fasta_file.save, "Saving fasta file not should succeed "


  end

  test "fixture fasta files exist" do
    FastaFile.find(:all).each do | ff |
      assert  File.exists?( ff.fasta.path ), "File #{ff.fasta.path} does not exist."
    end
  end
end
