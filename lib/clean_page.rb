require 'mechanize'

class CleanPage < ::WWW::Mechanize::Page
  cattr_accessor :charset
  def initialize(uri=nil, response=nil, body=nil, code=nil, mech=nil)    
    body = ::Iconv.iconv("US-ASCII//IGNORE//TRANSLIT",  @@charset, body+' ')[0][0..-2]
    body = HTMLEntitiesCleaner.clean(body)
    body = body.tr('`',"'")
    body.delete!("^")
    super(uri, response, body, code)
  end
end