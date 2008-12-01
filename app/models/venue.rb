class Venue < ActiveRecord::Base
  include Clear
  
  has_many :events, :dependent => :destroy
  has_many :venue_variants, :foreign_key => 'cleared_id'
  belongs_to :locality
  alias_method(:variants, :venue_variants)  
  
  def to_s
    name
  end  
end
