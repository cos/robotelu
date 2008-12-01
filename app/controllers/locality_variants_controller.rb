class LocalityVariantsController < ApplicationController  
  active_scaffold :locality_variant do |config|
    config.columns = [:id, :created_at, :review, :name, :crawler, :locality]
    config.update.columns = [:review, :locality]
    config.columns[:locality].form_ui = :select
    config.columns[:review].form_ui = :checkbox
    config.columns[:review].inplace_edit = true
  end
  
  def review_next
    @variant = LocalityVariant.find(:first, :conditions => {:review => true})
    if(@variant)
      if(@variant.cleared?)
        redirect_to review_locality_path(:id => @variant.locality.id)        
      else
        redirect_to :action => 'review', :id => @variant.id
      end
    else
      redirect_to review_next_venue_variants_path
    end
  end
  
  def review
    @variant = LocalityVariant.find params[:id]
    @possible_clears = Locality.find :all, :conditions => ["MATCH(name) AGAINST (? IN BOOLEAN MODE)", @variant.name]
    @locality = Locality.new(:name => @variant.name)
  end  
  
  def set_cleared
    @variant = LocalityVariant.find params[:id]
    @variant.cleared_id = params[:cleared_id]
    @variant.save!
    redirect_to :action => 'review_next'
  end
end
