class RemoveState < ActiveRecord::Migration
  def self.up
    remove_column :locality_variants, :state
    remove_column :venue_variants, :state
    remove_column :event_variants, :state
  end

  def self.down
  end
end
