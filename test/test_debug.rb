require_relative 'helper'

describe 'XML::SAX::Debug event method warning' do
  it 'warns #start_document' do
    assert_match regexp('start_document: []'), parse('<r/>')
  end

  it 'warns #end_document' do
    assert_match regexp('end_document: []'), parse('<r/>')
  end

  it 'warns #start_element_namespace' do
    assert_match regexp('start_element_namespace: ["r", [], nil, nil, []]'), parse('<r/>')
  end

  it 'warns #start_element with attributes' do
    assert_match regexp('start_element_namespace: ["r", [["id", "1"]], nil, nil, []]'), parse('<r id="1"/>')
  end

  it 'warns #end_element' do
    assert_match regexp('end_element_namespace: ["r", nil, nil]'), parse('<r/>')
  end

  it 'warns #characters' do
    assert_match regexp('characters: ["woot"]'), parse('<r>woot</r>')
  end

  it 'warns #comment' do
    assert_match regexp('comment: [" woot "]'), parse('<r><!-- woot --></r>')
  end

  it 'warns #cdata_block' do
    assert_match regexp('cdata_block: [" woot "]'), parse('<r><![CDATA[ woot ]]></r>')
  end

  protected
    def parse(xml)
      parser = Nokogiri::XML::SAX::PushParser.new(XML::SAX::Debug.new)
      capture_stderr do
        parser << xml
        parser.finish
      end
    end

    def regexp(string)
      Regexp.compile('^' + Regexp.escape(string))
    end

    def capture_stderr(&block)
      $stderr = StringIO.new
      yield
      result  = $stderr.rewind && $stderr.read
      $stderr = STDERR
      result
    end
end # DebugTest
