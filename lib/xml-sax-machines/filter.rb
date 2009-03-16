require 'delegate'

module XML
  module SAX

    # SAX Filter base class.
    #
    # Chain SAX filters together by delegating missing SAX event methods to the next filter in the chain. Simply call
    # super in any SAX event methods you overload to pass the call to the next filter in the chain.
    #
    # Extend this Class rather than <tt>Nokogiri::XML::SAX::Document</tt> which acts as a final filter.
    #
    # ==== See
    # * Nokogiri::XML::SAX::Document
    #
    #--
    # TODO:
    # * Examples.
    # * Be explicit? My guess is method_missing in DelegateClass is slower.
    class Filter < DelegateClass(Nokogiri::XML::SAX::Document)

      # The next filter in the chain.
      def filter
        __setobj__
      end

      # New filter instance.
      #
      # ==== Notes
      # Filter chains are built in reverse, the filter passed during construction is called *after* the current
      # filter.
      #
      # ==== See
      # * XML::SAX::Pipeline
      #
      # ==== Parameters
      # filter<Nokogiri::XML::SAX::Document>::
      #   Optional next <tt>XML::SAX::Filter</tt> or <tt>Nokogiri::XML::SAX::Document<tt>(final) in the chain.
      #   By default a <tt>Nokogiri::XML::SAX::Document</tt> will be used making the chain final.
      #
      # options<Hash>::
      #   Optional per-filter arguments.
      #
      #--
      # TODO:
      # * Barf if the filter isn't a Nokogiri::XML::SAX::Document or XML::SAX::Filter.
      def initialize(filter = nil, options = {})
        super filter || Nokogiri::XML::SAX::Document.new
      end

    end # Filter
  end # SAX
end # XML
