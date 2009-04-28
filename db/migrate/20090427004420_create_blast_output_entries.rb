class CreateBlastOutputEntries < ActiveRecord::Migration
  def self.up
    create_table :blast_output_entry do |t|
      t.integer :fasta_file_id, :bioentry_id
    end
  end

  def self.down
    drop_table :blast_output_entry
  end
end
