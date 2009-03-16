require File.join(File.dirname(__FILE__), 'test_helper')

class DebugTest < Test::Unit::TestCase
  context 'XML::SAX::Debug event method warning' do

    should 'warn #start_document' do
      assert_match regexp('start_document: []'), parse('<r/>')
    end

    should 'warn #end_document' do
      assert_match regexp('end_document: []'), parse('<r/>')
    end

    should 'warn #start_element' do
      assert_match regexp('start_element: ["r", []]'), parse('<r/>')
    end

    should 'warn #start_element with attributes' do
      assert_match regexp('start_element: ["r", ["id", "1"]]'), parse('<r id="1"/>')
    end

    should 'warn #end_element' do
      assert_match regexp('end_element: ["r"]'), parse('<r/>')
    end

    should 'warn #characters' do
      assert_match regexp('characters: ["woot"]'), parse('<r>woot</r>')
    end

    should 'warn #comment' do
      assert_match regexp('comment: [" woot "]'), parse('<r><!-- woot --></r>')
    end

    should 'warn #cdata_block' do
      assert_match regexp('cdata_block: [" woot "]'), parse('<r><![CDATA[ woot ]]></r>')
    end
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
