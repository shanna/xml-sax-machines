require File.join(File.dirname(__FILE__), 'test_helper')

class FragmentBuilderTest < Test::Unit::TestCase
  context 'XML::SAX::FragmentBuilder' do

    should 'call callback for record' do
      builder = XML::SAX::FragmentBuilder.new(
        '//foo' => lambda do |el|
          assert_equal 'foo', el.name, 'foo element'
          assert_equal 1, el.parent.children.length, 'no siblings'
        end
      )
      parser = Nokogiri::XML::SAX::PushParser.new(builder)
      parser << '<r><foo/><foo/><foo/></r>'
      parser.finish
    end

    should 'have buffered children for record' do
      builder = XML::SAX::FragmentBuilder.new(
        '//foo' => lambda{|el| assert_equal 2, el.children.length}
      )
      parser = Nokogiri::XML::SAX::PushParser.new(builder)
      parser << '<r><foo>text<el>el</el></foo></r>'
      parser.finish
    end

  end
end # FragmentBuilderTest
