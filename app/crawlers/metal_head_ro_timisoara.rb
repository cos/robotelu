class MetalHeadRoTimisoara < CrawlerProcess
  def crawl!    
  	agent = get_agent('UTF-8')
  	listing_page = agent.get('http://www.metalhead.ro/Concerte-si-Evenimente-Rock-si-Metal.html')
	
	with_context(:locality_name => "Timisoara") do
		events_listing_table = listing_page/"//td[@width='444']"
		events_listing_table.each do |event_listing| 
			event_url = (event_listing/"b/a").first[:href]
			event_title = (event_listing/"b/a").inner_html.clean_as_title
			
			event_page = agent.get(event_url)
			event_table = (event_page/"//table[@class='mainfont5']")
			event_date = (event_table/"tr[1]/td[2]").inner_text.chomp
			event_time = (event_table/"tr[2]/td[2]").inner_text.chomp
			event_location = (event_table/"tr[3]/td[2]").inner_text.chomp
			event_description = (event_table/"tr[4]/td[2]/div[@align='justify']").inner_text.chomp
			
			if event_title.include?("Timisoara") or event_location.include?("Timisoara")
				if event_location.include?("Timisoara") # Hack, some events don't have city in name but in location, while others only have it in location concatenated with the venue name
					event_location.gsub!(/- Timisoara/,"")
				end
				
				propose_event( :title=> event_title, :venue_name => event_location, :date => event_date, :time => event_time, :url => event_url, :description => event_description )
			end
		end
	end
  end
end