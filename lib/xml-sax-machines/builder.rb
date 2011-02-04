module XML
  module SAX

    # Build a Nokogiri::XML::Document from a SAX stream.
    #
    # ==== Example
    #
    #   builder =  XML::SAX::Builder.new
    #   parser  =  Nokogiri::XML::SAX::PushParser.new(builder)
    #   parser  << %q{<root>xml content</root>}
    #   parser.finish
    #
    #   puts builder.document.children.to_s #=> xml content
    #
    # ==== See
    # * XML::SAX::Filter
    #
    # --
    # TODO:
    # * Namespaces.
    class Builder < Filter

      # The document object.
      #
      # ==== Returns
      # Nokogiri::XML::Document
      attr_reader :document

      def start_document #:nodoc:
        super
        @document = Nokogiri::XML::Document.new
        @context  = @document
      end

      def start_element_namespace(name, attributes = [], prefix = nil, uri = nil, ns = [])
        super
        el           = Nokogiri::XML::Element.new(name, @document)
        el.namespace = el.add_namespace_definition(prefix, uri) if uri
        ns.each{|prefix, href| el.add_namespace_definition(prefix, href)}
        @context = @context.add_child(el)

        # Node needs to be added to the document so namespaces are available.
        attributes.each{|attribute| el[[attribute.prefix, attribute.localname].compact.join(':')] = attribute.value}
      end

      #--
      # TODO: Check namespace of context as well?
      def end_element_namespace(name, prefix = nil, uri = nil)
        super
        raise "Unmatched closing element. Got '#{name}' but expected '#{@context.name}'" \
          unless name == @context.name
        @context = @context.parent
      end

      def characters(string) #:nodoc:
        super
        # http://nokogiri.lighthouseapp.com/projects/19607-nokogiri/tickets/68-xpath-incorrect-when-text-siblings-exist#ticket-68-1
        sibling = @context.children.last
        if sibling.kind_of?(Nokogiri::XML::Text)
          sibling.content += string
        else
          @context.add_child(Nokogiri::XML::Text.new(string, @document))
        end
      end

      def cdata_block(string) #:nodoc:
        super
        @context.add_child(Nokogiri::XML::CDATA.new(@document, string))
      end

      def comment(string) #:nodoc:
        super
        @context.add_child(Nokogiri::XML::Comment.new(@document, string))
      end

    end # Builder
  end # SAX
end # XML
