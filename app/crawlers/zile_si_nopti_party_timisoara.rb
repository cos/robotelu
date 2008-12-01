class ZileSiNoptiPartyTimisoara < CrawlerProcess
  def crawl!    
    agent = get_agent('iso-8859-2')
    page = agent.get("http://zilesinopti.ro/index.php?oras=7&cat=28&mlt=true")
    page_no = 1
    loop do 
      page = agent.get("http://zilesinopti.ro/index.php?oras=7&cat=28&mlt=true&p="+page_no.to_s)            
      events = page.search('/html/body/table/tr[4]/td[2]/div[6]/div')    
      with_context(:locality_name => "Timisoara") do
        events.each do |e|
          # td/span/a
          next unless e.at('//a')
          next if e['class'] == 'paginare'

          title =        e.at('div[2]/div/a').inner_html          # /html/body/table/tbody/tr[4]/td[2]/div[6]/div[5]/div[2]/div/a
          title = title.clean_as_title

          venue_name =  e.at('div[2]/div/span[2]').inner_html.chop     # /html/body/table/tbody/tr[4]/td[2]/div[6]/div[4]/div[2]/div/span[2]
          venue_name.gsub!("La: ","")
          venue_name = venue_name.clean_as_title

          date =        e.at('div[2]/div/span').to_s.chop              # /html/body/table/tbody/tr[4]/td[2]/div[6]/div[8]/div[2]/div/span
          date = date.scan(/Data: (\d\d-\d\d-\d\d\d\d)/)[0][0]
                    

          url = e.at('div[2]/div/a')[:href]
          details_page = agent.get(url)
          description = details_page.at('/html/body/table/tr[4]/td[2]/div[3]/div[2]/div[2]/p').inner_html          
                    
          if(hour = description[/(ora|ORA) \d\d(.|:)\d\d {0,1}(-|LA|la) {0,1}\d\d(.|:)\d\d/])
            hour = hour.scan(/(\d\d(:|.)\d\d)/)
            start_hour = hour[0][0].sub('.',':')
            end_hour = hour[1][0].sub('.',':')
            log start_hour + end_hour
          else            
            if(hour = description[/(ora|ORA) \d\d(.|:)\d\d/])
              start_hour=hour[/(\d\d(:|.)\d\d)/].sub('.',':')
            end
          end
          
          log 'Event '+title+' at '+venue_name+' on '+date
          propose_event({
            :title => title,
            :venue_name => venue_name,
            :date => date,
            :time => start_hour,
            :end_time => end_hour,
            :description => description,
            :url => 'www.zilesinopti.ro/'+url
          })        
        end
      end                
      break unless page.at("/html/body/table/tr[4]/td[2]/div[6]/div[@class='paginare']/a:last")
      last_page_no = page.at("/html/body/table/tr[4]/td[2]/div[6]/div[@class='paginare']/a:last")['href'].scan(/p=(\d+)/)[0][0]      
      break if(last_page_no.to_s <= page_no.to_s)
      page_no+=1
    end    
  end  
end