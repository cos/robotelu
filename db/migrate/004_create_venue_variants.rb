class CreateVenueVariants < ActiveRecord::Migration
  def self.up
    create_table :venue_variants do |t|
      t.integer :venue_id
      t.integer :crawler_id
      t.string :state
      t.string :name
      t.integer :locality_variant_id
      t.text :address

      t.timestamps
    end
  end

  def self.down
    drop_table :venue_variants
  end
end
