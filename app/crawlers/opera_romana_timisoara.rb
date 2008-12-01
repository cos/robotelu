class OperaRomanaTimisoara < CrawlerProcess
  def crawl!    
    agent = get_agent('iso-8859-1')
    page = agent.get("http://www.ort.ro/")    
    with_context(:locality_name => "Timisoara", :venue_name => 'Opera Nationala Romana Timisoara') do      
      events = page/'/html/body/table/tr[12]/td/table/tr/td/table/tr[2]/td/table/tr'
      events.each do |e|
        begin
          title = e % 'td[2]/div/span[1]' 
          title = title.inner_html.clean_as_title
          
          date_time = e % 'td[2]/div/span[3]'
          date_time = date_time.inner_html          
          date = date_time.scan(/\d{1,2} [a-z]{3,10} \d\d\d\d/)[0]
          time = date_time.scan(/ora (\d{1,2}:\d\d)/)[0][0]
          
          url = e % 'td[2]/div/font/a'
          url = 'www.ort.ro/'+url['href']
          
          description = (e / "td[2]/div/span[@class='descriere']").collect do |part|
            strip_tags(part.to_s).humanize.strip
          end.delete_if {|el| el == '' }
          description += [(e % "td[2]/div/strong").inner_html.strip]
          description = description.join '<br/>'
          
          propose_event(:title => title, :date => date, :time => time, :url => url, :description => description)
        rescue
          
        end
      end
    end
  end
end