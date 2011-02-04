require_relative 'helper'

describe 'Builder' do
  it 'creates root' do
    assert_equal 'r', build('<r/>').root.name
  end

  it 'creates comments' do
    assert_equal '<!-- woot -->', build('<r><!-- woot --></r>').root.children.to_s
  end

  it 'creates cdata_blocks' do
    assert_equal '<![CDATA[ woot ]]>', build('<r><![CDATA[ woot ]]></r>').root.children.to_s
  end

  it 'creates characters' do
    assert_equal 'woot', build('<r>woot</r>').root.children.to_s
  end

  it 'creates empty element' do
    assert build('<r><foo/></r>').at('/r/foo')
  end

  it 'creates element with attributes' do
    el = build('<r><foo id="1"/></r>').at('/r/foo')
    assert_equal '1', el['id']
  end

  it 'creates element with child element' do
    assert build('<r><foo><bar/></foo></r>').at('/r/foo/bar')
  end

  it 'creates element with mixed content' do
    el = build('<r><foo>text<bar/></foo></r>').at('/r/foo')
    assert_equal 'text<bar/>', el.children.to_s
  end

  it 'creates element siblings' do
    el = build('<r><foo/><bar/></r>').root
    assert_equal 2, el.children.length
  end

  it 'creates elements with namespaces' do
    assert build('<r xmlns:bar="http://bar.local"><bar:foo/></r>').at('/r/bar:foo')
  end

  it 'create elements with namespaced attributes' do
    assert build('<r xmlns:bar="http://bar.local"><foo bar:id="1"/></r>').at('/r/foo[@bar:id="1"]')
  end

  protected
    def build(string)
      builder = XML::SAX::Builder.new
      parser  = Nokogiri::XML::SAX::PushParser.new(builder)
      parser << string
      parser.finish
      builder.document
    end
end # Builder
