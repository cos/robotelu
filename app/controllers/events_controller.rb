class EventsController < ApplicationController
  active_scaffold do |config|
    config.list.columns = [:id, :created_at, :updated_at, :title, :venue, :date, :end_date, :time, :end_time]
    config.update.columns = [:title, :keywords, :date, :venue, :time, :end_date, :end_time]
    config.columns[:venue].form_ui = :select           
    
    config.update.link.inline = false
    config.update.link.label = 'Review'
    config.update.link.parameters = {:action => 'review'}
  end
  
  def conditions_for_collection
    'date >= curdate()'
  end
  
  def review
    @event = Event.find params[:id]   
    @variants = @event.variants
    @possible_venues = @event.venue.locality.venues
  end
  
  def update_from_review
    @cleared = Event.find(params[:id])
    if(@cleared.update_attributes(params[:event]))
      @cleared.variants.each do |v|
        v.update_attribute(:review, false)
      end
      redirect_to review_next_event_variants_path
    else
      review
    end
  end
  
  def create_from_variant
    params[:event].delete_if { |key, value| key =~ /^time/ } if params[:ignore_time] == 'true'
    params[:event].delete_if { |key, value| key =~ /^end_date/ } if params[:ignore_end_date] == 'true'
    params[:event].delete_if { |key, value| key =~ /^end_time/ } if params[:ignore_end_time] == 'true'
    
    @event = Event.create(params[:event])
    if(@event)
      @variant = EventVariant.find params[:variant_id]
      @variant.review = false
      @variant.cleared_id = @event.id
      @variant.save!
      redirect_to review_next_event_variants_path
    else 
      redirect_to :back
    end
  end
end
