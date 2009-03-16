require File.join(File.dirname(__FILE__), 'test_helper')

class FilterTest < Test::Unit::TestCase
  context 'XML::SAX::Filter' do

    should 'run base filter without error' do
      assert_nothing_thrown do
        parser = Nokogiri::XML::SAX::PushParser.new(XML::SAX::Filter.new)
        parser << '<r/>'
        parser.finish
      end
    end

  end
end # FilterTest
