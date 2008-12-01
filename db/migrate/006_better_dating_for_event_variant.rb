class BetterDatingForEventVariant < ActiveRecord::Migration
  def self.up
    rename_column :event_variants, :start_date, :date
    add_column :event_variants, :end_date, :date
    add_column :event_variants, :time, :time
  end

  def self.down
    rename_column :event_variants, :date, :start_date
    remove_column :event_variants, :end_date
    remove_column :event_variants, :time
  end
end