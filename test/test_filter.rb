require_relative 'helper'

describe 'XML::SAX::Filter' do
  it 'runs base filter without error' do
    begin
      parser = Nokogiri::XML::SAX::PushParser.new(XML::SAX::Filter.new)
      parser << '<r/>'
      parser.finish
    rescue
      assert false
    else
      assert true
    end
  end
end
