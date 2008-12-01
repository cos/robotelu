class Locality < ActiveRecord::Base
  include Clear
  
  has_many :venues, :dependent => :destroy
  has_many :locality_variants, :foreign_key => 'cleared_id', :dependent => :nullify
  alias_method(:variants, :locality_variants)
  before_save 
end