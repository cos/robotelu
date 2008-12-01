class CrawlerWorker < BackgrounDRb::MetaWorker
  set_worker_name :crawler_worker
  def create(args = nil)
    # this method is called, when worker is loaded for the first time
  end
  
  def crawl_all(test)
    logger.info 'started crawl_all'
    cache[:status] = :working
    Crawler.find(:all).each do |c|      
      logger.info 'clawling: '+c.id
      cache[:current_crawler] = c.id
      c.crawl!
      cache[:current_crawler] = nil
    end
    cache[:status] = :idle
    logger.info 'ended crawl_all'
  end
  
  def crawl(crowler_id)
    cache[:current_crawler] = crowler_id    
    Crowler.find crowler_id
    @crawler.crawl!
    cache[:current_crawler] = nil
  end
end