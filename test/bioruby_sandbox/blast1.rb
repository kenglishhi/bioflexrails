#!/usr/bin/ruby

require 'rubygems'
require 'bio'

factory = Bio::Blast.local('blastn', '/home/kenglish/workspace/bioflexrails/public/system/fastas/18/original/EST_Clade_A_1.fasta')
ff = Bio::FlatFile.open(Bio::FastaFormat, '/home/kenglish/workspace/bioflexrails/public/system/fastas/18/original/EST_Clade_A_1.fasta')

ff.each do |entry|
   puts "Searching..." + entry.definition
   report = factory.query(entry)
   report.each do |hit|
     hit.each do |hsp|
       puts hsp.query_from
     end
   end
end
