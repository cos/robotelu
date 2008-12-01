class VenueVariant < ActiveRecord::Base
  include Variant    
  
  belongs_to :locality_variant
  has_many :event_variants, :dependent => :destroy        
  belongs_to :venue, :foreign_key => 'cleared_id'
  alias_method(:cleared, :venue)
  
  def cleared?
    !cleared.nil?
  end
  
  ##############
  # For crawing
  ##############
  def self.find_variant(hash)
    find :first, :conditions => {:crawler_id => hash[:crawler_id], :locality_variant_id => hash[:locality_variant_id], :name => hash[:name]}
  end  

  def identical? (hash)    
    hash[:address] == address
  end    
  
  
  
  def locality
    if cleared
      cleared.locality
    elsif locality_variant
      self.locality_variant.cleared
    else
      nil
    end
  end    
  
  def to_s
    name
  end
end