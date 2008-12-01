require 'facets/string'

class TimisoreniRoTimisoara < CrawlerProcess
  def crawl!    
  	agent = get_agent('UTF-8')
  	event_listing_page = agent.get('http://www.timisoreni.ro/evenimente/1.htm')
	
        event_listing_pages = []
        event_listing_pages << event_listing_page
        
        event_pages = []
        max_page = 1
        
        event_listing_page.search("div[@id='navigare']/a").each do |link|
          if link[:href] =~ /\/([0-9]*)\.htm/
         #   puts "Got page: "+link[:href]
            nr = link[:href].scan(/([0-9]+)\.htm/).first.first.to_i
            if nr>max_page; max_page = nr end
          end
          
        end
        
        (1..max_page).each do |i|
          event_pages << "http://www.timisoreni.ro/evenimente/"+i.to_s+".htm"
        end
        
        # For each event page get events, add to array
        alleventslinks = []
        event_pages.each do |event_page|
          page = agent.get(event_page)
          page.search("a[@class='titlu']") do |link|
            alleventslinks << link[:href]
          end
        end
        
        # WOhoo!. Now for each event URL go grab it, and extract information
        with_context(:locality_name => "Timisoara") do
          alleventslinks.each do |event_link|
            page = agent.get(event_link)
            event_title = page.search("div[@class='firma_titlu']").first.inner_text.to_s
            event_date = page.search("div[@class='firma']/ul/li")[0].inner_text.gsub("Data inceput: ","")
            event_location = page.search("div[@class='firma']/ul/li")[2].inner_text.gsub("Locatie: ","")
            event_location -= 'Timisoara - '
            # TODO: Event description is kinky..whitespace issues and stuff
            # TODO: Check actual encoding of page/description. MySQL gave an invalid value for text field
            event_description = page.search("div[@class='firma']").inner_text
            
            # TODO: Sometimes fucks with erro :)
            begin
              propose_event( :title=> event_title, :venue_name => event_location, :date => event_date, :url => event_link, :description => event_description )
            rescue
            end
          end      
        end
  end
end