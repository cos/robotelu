class CreateEventVariants < ActiveRecord::Migration
  def self.up
    create_table :event_variants do |t|
      t.integer :event_id
      t.integer :crawler_id
      t.string :state
      t.string :title
      t.integer :venue_variant_id
      t.date :start_date
      t.time :start_time

      t.timestamps
    end
  end

  def self.down
    drop_table :event_variants
  end
end
