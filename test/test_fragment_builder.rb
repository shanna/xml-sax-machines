require_relative 'helper'
# TODO: These tests don't fail if the lambda doesn't run.

describe 'XML::SAX::FragmentBuilder' do
  it 'calls callback for record' do
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

  it 'buffers children for record' do
    builder = XML::SAX::FragmentBuilder.new(
      '//foo' => lambda{|el| assert_equal 2, el.children.length}
    )
    parser = Nokogiri::XML::SAX::PushParser.new(builder)
    parser << '<r><foo>text<el>el</el></foo></r>'
    parser.finish
  end

  it 'handles namespaces like a boss' do
    builder = XML::SAX::FragmentBuilder.new(
      '//foo:title' => lambda{|el|
        assert_equal 'foo',              el.namespace.prefix
        assert_equal 'http://foo.local', el.namespace.href
        assert_equal 'title',            el.name
      }
    )
    parser = Nokogiri::XML::SAX::PushParser.new(builder)
    parser << '<r xmlns:foo="http://foo.local"><title /><foo:title/></r>'
    parser.finish
  end
end
