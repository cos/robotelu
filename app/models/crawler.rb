class Crawler < ActiveRecord::Base
  has_many :log_entries, :as => :subject
  
  has_many :locality_variants, :dependent => :destroy
  has_many :venue_variants, :dependent => :destroy
  has_many :event_variants, :dependent => :destroy
  
  def crawl!    
    crowler_process_name = self.name.gsub(' ','_').underscore.camelize        
    refresh_crawler_process_class(crowler_process_name) # if ENV['RAILS_ENVIROMENT'] != 'production'            
    crowler_process_name.constantize.instance.crawl!
    
    log_crawl!
  end
  
  # Refresh the crawler process code
  def refresh_crawler_process_class(us)
    ConstantCaching.clear_constant('LocalityVariant')    

    Object.class_eval do
      if const_defined?(us)
        remove_const(us)
      end
    end
    load 'app/crawlers/'+us.underscore+'.rb'
  end
  
  def log_crawl!
    self.last_crawled_at = DateTime.now
    self.crawls_count+=1
    save!
  end
  
  def clear_variants
    locality_variants.each do |lv|
      lv.destroy
    end
    venue_variants.each do |vv|
      vv.destroy
    end
    event_variants.each do |vv|
      vv.destroy
    end    
  end
  
  def to_s
    name
  end
end
