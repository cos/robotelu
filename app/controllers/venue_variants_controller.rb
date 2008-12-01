class VenueVariantsController < ApplicationController
  active_scaffold do |config|
    config.list.columns = [:id, :created_at, :review, :name, :locality_variant, :address, :crawler, :venue]
    config.update.columns = [:review, :locality_variant, :venue]
    config.columns[:locality_variant].form_ui = :select
    config.columns[:venue].form_ui = :select
    config.columns[:review].form_ui = :checkbox
    config.columns[:review].inplace_edit = true          
  end 
  
  def review_next
    @variant = VenueVariant.find(:first, :conditions => {:review => true})
    if(@variant)
      if(@variant.cleared?)
        redirect_to review_venue_path(:id => @variant.venue.id)        
      else
        redirect_to :action => 'review', :id => @variant.id
      end
    else
      redirect_to review_next_event_variants_path
    end
  end
  
  def review
    @variant = VenueVariant.find params[:id]    
    conditions = ["MATCH(name) AGAINST (? IN BOOLEAN MODE) ", @variant.name]
    if(@variant.locality)
      conditions[0] += "and locality_id = ?"
      conditions << @variant.locality.id
    end
    @possible_clears = Venue.find :all, :conditions => conditions
    @venue = Venue.new(:name => @variant.name, :address => @variant.address, :locality => @variant.locality)
  end  
  
  def set_cleared
    @variant = VenueVariant.find params[:id]
    @variant.cleared_id = params[:cleared_id]
    @variant.save!
    redirect_to :action => 'review_next'
  end
  
  def skip_as_incorrect
    variant = VenueVariant.find params[:id]
    variant.cleared_id = nil
    variant.review = false
    variant.save!
    redirect_to :action => 'review_next'
  end
end