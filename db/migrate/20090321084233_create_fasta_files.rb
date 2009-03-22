class CreateFastaFiles < ActiveRecord::Migration
  def self.up
    create_table :fasta_file do |t|
      t.string :label
      t.string  :fasta_file_name, :fasta_content_type
      t.integer :fasta_file_size
      t.timestamps
    end
  end

  def self.down
    drop_table :fasta_file
  end
end
