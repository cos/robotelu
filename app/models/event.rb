class Event < ActiveRecord::Base
  include Clear

  belongs_to :venue
  has_many :event_variants, :foreign_key => 'cleared_id', :dependent => :nullify
  alias_method(:variants, :event_variants)  
 
end
