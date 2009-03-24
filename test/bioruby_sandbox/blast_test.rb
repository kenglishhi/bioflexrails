#!/usr/bin/ruby
require File.dirname(__FILE__) + '/../test_helper'
#require File.dirname(__FILE__) + '/../../lib/bio_utils.rb'


class BlastTest < ActiveSupport::TestCase
     include BioUtils

  test "the truth" do
     blastn_2_files('/home/kenglish/Data/EST_Clade_A_1.fasta', '/home/kenglish/Data/EST_Clade_A_5.fasta') 
  end
end
  




