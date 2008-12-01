# A "Variant" is the abstract form of LocalityVariant, VenueVariant, EventVariant or anything else 
# that has been proposed  by some means
# A Variant is evaluated in several stages before becoming an actual "Clear" object (Locality, Event, etc...)

module Variant
  def self.included(base) 
    base.extend ClassMethods
    base.class_eval do                
      belongs_to :crawler
      validates_presence_of :crawler_id                        
    end
  end
  
  module ClassMethods        
    def propose(hash)            
      v = find_variant(hash)
      if v && !v.identical?(hash)
        v.review = true
        v.update_attributes!(hash)
      end
      v || create!(hash)
    end
  end
end