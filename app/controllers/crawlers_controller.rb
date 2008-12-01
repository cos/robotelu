class CrawlersController < ApplicationController
  active_scaffold do |config|
    config.show.link.page = true
    config.columns = [:last_crawled_at, :name]
  end
  
  def crawl
    @crawler = Crawler.find(params[:id])
    
    @crawler.crawl!    
    # MiddleMan.ask_work(:worker => :lonely_worker, :worker_method => :crawl, :data => @crawler.name)
    respond_to do |format|
      format.html { redirect_to crawler_path(@crawler) }
      format.xml  { render :xml => @notices }
    end
  end
  
  def clear_variants
    @crawler = Crawler.find(params[:id])
    
    @crawler.clear_variants
    respond_to do |format|
      format.html { redirect_to crawler_path(@crawler)}
      format.xml  { render :xml => @notices }
    end
  end
  
  def show
    @crawler = Crawler.find params[:id]    
    @last_log = if (last_crawl_log = @crawler.log_entries.find(:first, :order => 'id desc'))
      last_crawl_log.text
    end
  end
end
