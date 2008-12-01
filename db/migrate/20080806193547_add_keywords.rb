class AddKeywords < ActiveRecord::Migration
  def self.up
    add_column :venue_variants, :keywords, :string
    add_column :event_variants, :keywords, :string
    
    add_column :venues, :keywords, :string
    add_column :events, :keywords, :string    
  end

  def self.down
  end
end
