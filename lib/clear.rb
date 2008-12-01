module Clear
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do      
      before_destroy :decouple_variants      
    end
  end  
  
  def decouple_variants
    variants.each do |v|
      v.review = true
      v.cleared_id = nil
      v.save!
    end
  end
  
  module ClassMethods
  end
end
