class DashboardController < ApplicationController
  def overview    
  end
  
  def worker_status    
    @status = MiddleMan.worker(:crawler_worker).ask_result(:status)
    render :text => 'Status:'+@status.to_s, :layout => false    
  end
  
  def statistics
    @locality_reviews = LocalityVariant.count :conditions => {:review => true}    
    @venue_reviews = VenueVariant.count :conditions => {:review => true}    
    @event_reviews = {}
    @event_reviews[:new] = EventVariant.count :conditions => "review = 1 and cleared_id is null and (date>=curdate() or end_date>=curdate())"
    @event_reviews[:changed] = EventVariant.count :conditions => "review = 1 and cleared_id is not null"
    
    @active_events = Event.count :conditions => ["date >= curdate()"]
    @old_events = Event.count :conditions => ["date < curdate()"]
  end
  
  def start_crawler
    MiddleMan.new_worker(:worker => :crawler_worker)
    redirect_to :action => 'overview'
  end
  
  def crawl
     MiddleMan.worker(:crawler_worker).async_crawl_all(:arg => 'test')
     redirect_to :action => 'overview'
  end
end