class DescriptionForEvent < ActiveRecord::Migration
  def self.up
    add_column :event_variants, :description, :text
  end

  def self.down
    remove_column :event_variants, :description
  end
end
