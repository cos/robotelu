class CreateLocalityVariants < ActiveRecord::Migration
  def self.up
    create_table :locality_variants do |t|
      t.string :name
      t.integer :locality_id
      t.integer :crawler_id
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :locality_variants
  end
end
