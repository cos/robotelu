class CreateCrawlers < ActiveRecord::Migration
  def self.up
    create_table :crawlers do |t|
      t.string :name
      t.datetime :last_crawled_at
      t.integer :crawls_count, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :crawlers
  end
end
