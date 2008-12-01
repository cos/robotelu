class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.integer :venue_id
      t.date :date
      t.time :time
      t.date :end_date
      t.time :end_time
      t.string :url
      t.text :description

      t.timestamps
    end
    
    rename_column :event_variants, :start_time, :end_time
  end

  def self.down
    drop_table :events
    rename_column :event_variants, :end_time, :start_time
  end
end
