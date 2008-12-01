class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.string :name
      t.string :alternative_names
      t.string :locality_id
      t.string :address
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :venues
  end
end
