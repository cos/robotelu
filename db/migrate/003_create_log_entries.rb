class CreateLogEntries < ActiveRecord::Migration
  def self.up
    create_table :log_entries do |t|
      t.string :subject_type
      t.integer :subject_id
      t.string :level
      t.string :title
      t.text :text, :detault => ""

      t.timestamps
    end
  end

  def self.down
    drop_table :log_entries
  end
end
