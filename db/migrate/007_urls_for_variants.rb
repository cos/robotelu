class UrlsForVariants < ActiveRecord::Migration
  def self.up
    add_column :locality_variants, :url, :string
    add_column :venue_variants, :url, :string
    add_column :event_variants, :url, :string
  end

  def self.down
    remove_column :locality_variants, :url
    remove_column :venue_variants, :url
    remove_column :event_variants, :url
  end
end
