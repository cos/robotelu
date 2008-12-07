require 'mechanize'
require 'html_entities_cleaner'

class CleanPage < ::WWW::Mechanize::Page
  def self.charset
    @@charset
  end
  def self.charset=(value)
    @@charset = value
  end  
  def initialize(uri=nil, response=nil, body=nil, code=nil, mech=nil)    
    body = ::Iconv.iconv("US-ASCII//IGNORE//TRANSLIT",  @@charset, body+' ')[0][0..-2]
    body = HTMLEntitiesCleaner.clean(body)
    body = body.tr('`',"'")
    body.delete!("^")
    super(uri, response, body, code)
  end
end