class CreateBlastCommands < ActiveRecord::Migration
  def self.up
    create_table :blast_command do |t|
      t.integer :query_biodatabase_id , :db_biodatabase_id, :term_id
      t.float   :evalue
      t.integer :identity , :score 
      t.timestamps
    end
  end

  def self.down
    drop_table :blast_command
  end
end
