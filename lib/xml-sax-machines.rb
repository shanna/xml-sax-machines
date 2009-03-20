begin
  require 'nokogiri'
rescue LoadError
  require 'rubygems'
  require 'nokogiri'
end

module XML
  module SAX
  end # SAX
end # XML

# TODO: Conditionally load some machines?
base = File.join(File.dirname(__FILE__), 'xml-sax-machines')
%w{filter pipeline debug builder fragment_builder}.each{|r| require File.join(base, r)}
