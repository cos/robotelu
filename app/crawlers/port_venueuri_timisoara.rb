class PortVenueuriTimisoara < CrawlerProcess
  def crawl!    
    agent = get_agent('iso-8859-2')
    page = agent.get("http://port.ro/pls/re/restaurant.restaurant_list?i_condition_id=-1&i_dist_id=-1&i_city_id=-1&i_county_id=38&i_cntry_id=56&i_from=1")        
    venues = page.search('/html/body/table[3]/tr/td/table/tr')    
    with_context(:locality_name => "Timisoara") do
      venues.each do |v|
        # td/span/a
        next unless v.at('//a')
        name = v.at('td[1]/span/a').inner_html.clean_as_title
        address = v.at('td[3]/').inner_text.strip.chop
        log 'Venue '+name+' with address '+address        
        propose_venue({
              :name => name,               
              :address => address 
              })
      end
    end
  end
end