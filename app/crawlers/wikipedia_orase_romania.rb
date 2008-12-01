class WikipediaOraseRomania < CrawlerProcess
  def crawl!             
    log 'Starting crawling'
    agent = get_agent('utf-8')
    page = agent.get("http://ro.wikipedia.org/wiki/Lista_ora%C5%9Felor_din_Rom%C3%A2nia")        
    orase = page.search('/html/body/div/div/div/div[2]/table[3]/tr/td[1]/a')    
    n = 0 
    orase.each do |oras|
      n+=1
      nume_oras = oras.inner_html.clean_as_title
      propose_locality(:name => nume_oras)
    end
  end
end