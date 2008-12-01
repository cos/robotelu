class EventVariant < ActiveRecord::Base
  include Variant 

  belongs_to :venue_variant  
  belongs_to :event, :foreign_key => 'cleared_id'  
  alias_method(:cleared, :event)        
  
  def cleared?
    !cleared.nil?
  end
  
  ##############
  # For crawing
  ##############
  def self.find_variant(hash)
    find :first, :conditions => {
      :crawler_id => hash[:crawler_id], 
      :venue_variant_id => hash[:venue_variant_id], 
      :date => Date.parse(hash[:date]).to_s}
  end
  
  def identical? (hash)
    hash[:title] == title && 
    (!hash[:time] || time == DateTime.parse(hash[:time])) &&
    (!hash[:end_date] || end_date == Date.parse(hash[:end_date])) &&
    (!hash[:end_time] || end_time == DateTime.parse(hash[:end_time]))
  end  
  
  def venue
    if cleared
      cleared.venue
    elsif venue_variant
      self.venue_variant.cleared
    else
      nil
    end
  end   
end