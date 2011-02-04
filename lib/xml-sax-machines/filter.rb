module XML
  module SAX

    # SAX Filter base class.
    #
    # Chain SAX filters together by delegating missing SAX event methods to the next filter in the chain. Simply call
    # super in any SAX event methods you overload to pass the call to the next filter in the chain.
    #
    # Extend this Class rather than <tt>Nokogiri::XML::SAX::Document</tt> which acts as a final filter.
    #
    # ==== Notes
    # Filter chains are built in reverse by setting the filter attribute. Use <tt>XML::SAX::Pipeline</tt> to
    # construct filter chains in a more logical order. This keeps the filter constructor clear of any prerequisite
    # API in subclasses.
    #
    # ==== See
    # * XML::SAX::Pipeline
    # * Nokogiri::XML::SAX::Document
    #
    #--
    # TODO:
    # * Examples.
    class Filter < Nokogiri::XML::SAX::Document

      # Barf if the filter isn't a Nokogiri::XML::SAX::Document or XML::SAX::Filter.
      # The next filter in the chain.
      attr_accessor :filter

      def cdata_block(string) #:nodoc:
        @filter.cdata_block(string) if @filter
      end

      def characters(string) #:nodoc:
        @filter.characters(string) if @filter
      end

      def comment(string) #:nodoc:
        @filter.comment(string) if @filter
      end

      def end_document #:nodoc:
        @filter.end_document if @filter
      end

      def end_element_namespace(name, prefix = nil, uri = nil) #:nodoc:
        @filter.end_element_namespace(name, prefix, uri) if @filter
      end

      def error(string) #:nodoc:
        @filter.error(string) if @filter
      end

      def start_document #:nodoc:
        @filter.start_document if @filter
      end

      def start_element_namespace(name, attributes = [], prefix = nil, uri = nil, ns = []) #:nodoc:
        @filter.start_element_namespace(name, attributes, prefix, uri, ns) if @filter
      end

      def warning(string) #:nodoc:
        @filter.warning(string) if @filter
      end

    end # Filter
  end # SAX
end # XML

