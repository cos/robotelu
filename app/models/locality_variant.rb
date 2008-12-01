class LocalityVariant < ActiveRecord::Base  
  include Variant     
  
  has_many :venue_variants, :dependent => :destroy  
  belongs_to :locality, :foreign_key => 'cleared_id'  
  alias_method(:cleared, :locality)
  
  def cleared?
    !locality.nil?
  end
  
  ##############
  # For crawing
  ##############
  def self.find_variant(hash)
    find :first, :conditions => {:crawler_id => hash[:crawler_id], :name => hash[:name]}
  end    
  
  def identical?(hash)
    false
  end
  
  def to_s
    crawler.to_s + ' - '+name
  end
end