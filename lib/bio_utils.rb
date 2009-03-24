module  BioUtils

  def blastn_2_files(fasta_query_file, db_file) 
    puts "HELLO BUDDY"
    factory = Bio::Blast.local('blastn', fasta_query_file )
    ff = Bio::FlatFile.open(Bio::FastaFormat, db_file )

    ff.each do |entry|
      puts "Searching..." + entry.definition
#   puts "Searching..." + entry.seq


      report = factory.query(entry)
      fasta_data = ""
#   debugger
      puts  "HITS = #{report.hits} fasta_data.empty? #{fasta_data.empty?}"
      unless report.hits.empty?
        puts "FASTA DAT "
        fasta_data << Bio::Sequence::NA.new(entry.seq).to_fasta(entry.definition)
      end
#   puts report.inspect 
      report.each do |hit|
        puts "DATA"
        hit.each do |hsp|
          if hit.evalue < 0.0001
            puts hsp.query_from
#           puts hsp.evalue
#           puts hsp.inspect
#           puts hsp.hseq.inspect
#j           puts hsp.hseq
            s = Bio::Sequence::NA.new(hsp.hseq)
            fasta_data << Bio::Sequence::NA.new(entry.seq).to_fasta
          else
            puts "evalue too big #{hit.evalue}"
          end
        end
      end
      unless fasta_data.empty?
        puts "FASTA DATA #{ fasta_data} "
      end
    end
  end
  private 
end

