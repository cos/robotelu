class LocalitiesController < ApplicationController
  active_scaffold do |config|
    config.list.columns = [:id, :created_at, :updated_at, :name, :venues]    
  end
  
  def review
    @locality = Locality.find params[:id]   
    @variants = @locality.variants
  end
  
  def update_from_review
    @cleared = Locality.find(params[:id])
    if(@cleared.update_attributes(params[:cleared]))
      @cleared.variants.each do |v|
        v.update_attribute(:review, false)
      end
      redirect_to review_next_locality_variants_path
    else
      review
    end
  end
  
  def create_from_variant
    @locality = Locality.create(params[:locality])
    if(@locality)
      @variant = LocalityVariant.find params[:variant_id]
      @variant.review = false
      @variant.cleared_id = @locality.id
      @variant.save!
      redirect_to review_next_locality_variants_path
    else 
      redirect_to :back
    end
  end
  
end