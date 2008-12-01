class VenuesController < ApplicationController
  active_scaffold do |config|
    config.list.columns = [:id, :created_at, :updated_at, :name, :locality, :address, :keywords]
    config.update.columns = [:name, :locality, :address, :keywords]
    config.columns[:locality].form_ui = :select    
  end
  
  def review
    @venue = Venue.find params[:id]   
    @variants = @venue.variants
  end
  
  def update_from_review
    @cleared = Venue.find(params[:id])
    if(@cleared.update_attributes(params[:cleared]))
      @cleared.variants.each do |v|
        v.update_attribute(:review, false)
      end
      redirect_to review_next_venue_variants_path
    else
      review
    end
  end
  
  def create_from_variant
    @venue = Venue.create(params[:venue])
    if(@venue)
      @variant = VenueVariant.find params[:variant_id]
      @variant.review = false
      @variant.cleared_id = @venue.id
      @variant.save!
      redirect_to review_next_venue_variants_path
    else 
      redirect_to :back
    end
  end
end
