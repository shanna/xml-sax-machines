require File.join(File.dirname(__FILE__), 'test_helper')

class BuilderTest < Test::Unit::TestCase
  context 'XML::SAX::Builder' do

    should 'create root' do
      assert_equal 'r', build('<r/>').root.name
    end

    should 'create comments' do
      assert_equal '<!-- woot -->', build('<r><!-- woot --></r>').root.children.to_s
    end

    should 'create cdata_blocks' do
      assert_equal '<![CDATA[ woot ]]>', build('<r><![CDATA[ woot ]]></r>').root.children.to_s
    end

    should 'create characters' do
      assert_equal 'woot', build('<r>woot</r>').root.children.to_s
    end

    should 'create empty element' do
      assert build('<r><foo/></r>').at('/r/foo')
    end

    should 'create element with attributes' do
      el = build('<r><foo id="1"/></r>').at('/r/foo')
      assert_equal '1', el['id']
    end

    should 'create element with child element' do
      assert build('<r><foo><bar/></foo></r>').at('/r/foo/bar')
    end

    should 'create element with mixed content' do
      el = build('<r><foo>text<bar/></foo></r>').at('/r/foo')
      assert_equal 'text<bar/>', el.children.to_s
    end

    should 'create element siblings' do
      el = build('<r><foo/><bar/></r>').root
      assert_equal 2, el.children.length
    end
  end

  protected
    def build(string)
      builder = XML::SAX::Builder.new
      parser  = Nokogiri::XML::SAX::PushParser.new(builder)
      parser << string
      parser.finish
      builder.document
    end
end # BuilderTest
