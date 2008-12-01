class CreateLocalities < ActiveRecord::Migration
  def self.up
    create_table :localities do |t|
      t.string :name
      t.string :alternative_names

      t.timestamps
    end
  end

  def self.down
    drop_table :localities
  end
end
