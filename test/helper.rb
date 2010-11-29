$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'minitest/spec'
require 'minitest/unit'
require 'xml-sax-machines'

MiniTest::Unit.autorun
