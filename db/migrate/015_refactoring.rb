class Refactoring < ActiveRecord::Migration
  def self.up
    rename_column :event_variants, :event_id, :cleared_id
    rename_column :venue_variants, :venue_id, :cleared_id
    rename_column :locality_variants, :locality_id, :cleared_id
    
    add_column :event_variants, :review, :boolean, :default => true
    add_column :venue_variants, :review, :boolean, :default => true
    add_column :locality_variants, :review, :boolean, :default => true
  end

  def self.down
  end
end