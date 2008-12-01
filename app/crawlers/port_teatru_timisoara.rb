class PortTeatruTimisoara < CrawlerProcess
  def crawl!    
    agent = get_agent('iso-8859-2')
    page = agent.get("http://port.ro/pls/th/theatre.theatre_body?i_org_id=999&i_city_id=22&i_county_id=38&i_cntry_id=56")
    venues = page.search('/html/body/table[3]/tr/td/table/tr')
    with_context(:locality_name => "Timisoara") do
      venues.each do |v|
        # td/span/a
        next unless v.at('//a')
        
        link = v.at('td[1]/span/a')  
        name = link.inner_html.clean_as_title
        address = v.at('td[3]/').inner_text.strip.chop
        
        log 'Venue '+name+' with address '+address
        with_context :venue => { :name => name,    :address => address  } do
          page = agent.click link
          date = ""
          (page/"/html/body/table[@width='100%']").each do |__table|
            if(__table.at("tr/td[@class='lightgray']"))
              if __table.at("tr/td/span")
                date = __table.at("tr/td/span").inner_html 
                date = date.scan(/\((\d{1,2} [a-z]{3,10}).*\)/)[0][0] + " "+DateTime.now.year.to_s
              end
            else
              (__table/'tr').each do |_event|
                next if _event.to_s.include?("Spectacolul se desf")
                next unless _event.at('td[1]/div/span/a') && _event.at('td[2]/span/a')
                time = _event.at('td[1]/div/span/a').inner_html
                title = _event.at('td[2]/span/a').inner_html #/html/body/table[11]/tbody/tr/                
                propose_event(:title => title, :date => date, :time => time)
              end
            end            
          end          
          page = agent.back
        end
      end
    end
  end
end