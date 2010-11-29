require_relative 'helper'

describe 'XML::SAX::Filter' do
  it 'chains filters first to last' do
    class Debug1 < XML::SAX::Debug; end
    class Debug2 < XML::SAX::Debug; end
    class Debug3 < XML::SAX::Debug; end

    pipe = XML::SAX::Pipeline.new(
      Debug1.new,
      Debug2.new,
      Debug3.new
    )
    assert_kind_of Debug1, pipe.filter
    assert_kind_of Debug2, pipe.filter.filter
    assert_kind_of Debug3, pipe.filter.filter.filter
  end
end
