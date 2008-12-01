require 'singleton'
require 'clean_page'

class CrawlerProcess
  include Singleton 
  include ::ActionView::Helpers::SanitizeHelper
  
  def get_agent(charset)
    agent = WWW::Mechanize.new
    CleanPage.charset = charset
    agent.pluggable_parser.html = CleanPage
    agent.user_agent = 'Robotelu Urmeaza'
    agent
  end
  
  def with_context(context, &code)        
    if context.is_a? Hash
      @locality_variant_id = slice_locality_variant(context) || @locality_variant_id
      @venue_variant_id = slice_venue_variant(context) || @venue_variant_id
    else
      if context.is_a? VenueVariant
        @venue_variant_id = context.id
      elsif context.is_a? LocalityVariant
        @locality_variant_id = context.id
      end
    end
    
    code.call 
  end
  
  def slice_locality_variant(hash)
    if hash[:locality_name]
      hash[:locality_variant_id] ||= propose_locality(:name => hash[:locality_name]).id
      hash.delete(:locality_name)
    end    
    if hash[:locality]
      hash[:locality_variant_id] ||= propose_locality(:name => hash[:locality][:name]).id
      hash.delete(:locality)
    end
    hash[:locality_variant_id] ||= @locality_variant_id
  end

  def slice_venue_variant(hash)
    slice_locality_variant(hash)
    if hash[:venue_name]
       hash[:venue_variant_id] ||= propose_venue(
            :name => hash[:venue_name], 
            :locality_variant_id => hash[:locality_variant_id],
            :address => hash[:venue_address]
            ).id            
       hash.delete(:venue_name)
       hash.delete(:locality_variant_id)
       hash.delete(:venue_address)
    end
    if _v = hash[:venue]       
       hash[:venue_variant_id] ||= propose_venue(
            :name => _v[:name], 
            :locality_variant_id => hash[:locality_variant_id] || _v[:locality_variant_id],
            :address => _v[:address]
            ).id
       hash.delete(:venue)       
    end
    hash.delete(:locality_variant_id)
    hash[:venue_variant_id] ||= @venue_variant_id
  end
  
  # Requires :name
  def propose_locality(hash)   
    hash[:crawler_id] = crawler_model.id        
    LocalityVariant.propose(hash)
  end
  
  def propose_venue(hash)
    slice_locality_variant(hash)
    hash[:crawler_id] = crawler_model.id
    VenueVariant.propose(hash)
  end
  
  def propose_event(hash)
    slice_venue_variant(hash)    
    hash[:crawler_id] = crawler_model.id
    EventVariant.propose(hash)
  end
  
  def log (s)
    @log ||=
      begin
        log = LogEntry.new
        log.subject = crawler_model
        log.title = 'Crawl report for crawl number: '+(crawler_model.crawls_count+1).to_s
        log
      end
    @log << s 
  end
  
  def crawler_model
    @crawler_model or Crawler.find_by_name(self.class.to_s.titleize) or throw 'Could not find crawler model '+self.class.to_s.titleize
  end  
end