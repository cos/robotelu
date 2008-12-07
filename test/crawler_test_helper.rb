$:.unshift File.join(File.dirname(__FILE__),'..','lib')
$:.unshift File.join(File.dirname(__FILE__),'..','app','crawlers')

require 'iconv'
require 'test/unit'
require 'shoulda'
require 'mocha'
require 'crawler_process'