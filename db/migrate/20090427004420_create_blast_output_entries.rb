class CreateBlastOutputEntries < ActiveRecord::Migration
  def self.up
    create_table :blast_output_entries do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :blast_output_entries
  end
end
