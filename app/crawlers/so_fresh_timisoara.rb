# DISCLAIMER: HAS NOT BEEN TESTED AT ALL! ( only the xpaths of course )
class SoFreshTimisoara < CrawlerProcess
  def crawl!    
  	agent = get_agent('UTF-8')
  	posts_listing = agent.get('http://www.sofresh.ro/index.php')
	post_headers_list = posts_listing/"//div[@class='post']"
	
	with_context(:locality_name => "Timisoara") do
		post_headers_list.each do |header|
	
			if (header/'h1').inner_text.include?("/ Timisoara /")
				event_to_parse = (header./'h1').inner_text
				event_url = (header/"h1/a").first[:href]
				
				event_to_parse.gsub!("/ Timisoara /","@")
				event_name, event_location, event_date = event_to_parse.split(/@/) 
				if !(event_date.include?("2008"))
					event_date = event_date+" 2008"
				end
				event_description = (header/"div[@class='entry']").inner_text
				
				# TODO: No real time available here....what should we do? :)
				propose_event( :title=> event_name, :venue_name => event_location, :date => event_date, :url => event_url, :description => event_description )
			end
		end
	end
  end
end