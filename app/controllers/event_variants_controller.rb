class EventVariantsController < ApplicationController
  active_scaffold do |config|
    config.list.columns = [:id, :created_at, :review, :title, :url, :date, :time,  :end_date, :venue_variant,  :crawler, :event]
    config.update.columns = [:review, :venue_variant, :event, :url]
    config.columns[:venue_variant].form_ui = :select
    config.columns[:event].form_ui = :select
    config.columns[:review].form_ui = :checkbox
    config.columns[:review].inplace_edit = true       
  end

  def review_next
    @variant = EventVariant.find(:first, :conditions => ["review = 1 and (date>=curdate() or end_date>=curdate())"])
    if(@variant)
      if(@variant.cleared?)
        redirect_to review_event_path(:id => @variant.cleared.id)        
      else
        redirect_to :action => 'review', :id => @variant.id
      end
    else
      redirect_to :controller => 'dashboard', :action => 'overview'
    end
  end
  
  def review
    @variant = EventVariant.find params[:id]    
    
    
    conditions = ["MATCH(title) AGAINST (? IN BOOLEAN MODE) ", @variant.title]
    if(@variant.venue)
      conditions[0] += "and venue_id = ? "
      conditions << @variant.venue.id
    end
    if(@variant.date)
      conditions[0] += " and date = ? "
      conditions << @variant.date
    end
    @possible_clears = Event.find :all, :conditions => conditions
        
    @event = Event.new(
        :venue_id => ((@variant.venue.id if @variant.venue) || Venue.find(82).id),
        :title => @variant.title,
        :date => @variant.date,
        :time => @variant.time,
        :end_date => (@variant.end_date || @variant.date),
        :end_time => (@variant.end_time || @variant.time),
        :description => @variant.description,
        :url => @variant.url
      )     

    @possible_venues = 
      if @variant.venue && @variant.venue.locality
        @variant.venue.locality.venues :order => 'name'
      else
        Venue.find :all, :order => 'name'
      end
  end  
  
  def set_cleared
    @variant = EventVariant.find params[:id]
    @variant.cleared_id = params[:cleared_id]
    @variant.save!
    redirect_to :action => 'review_next'
  end

  def skip_as_incorrect
    variant = EventVariant.find params[:id]
    variant.cleared_id = nil
    variant.review = false
    variant.save!
    redirect_to :action => 'review_next'
  end
end
