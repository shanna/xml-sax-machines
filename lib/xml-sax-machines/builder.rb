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

      def start_element(name, attributes = []) #:nodoc:
        super

        # TODO: Bug in nokogiri or my code. It freaks out sometimes on fast machines if you modify the tree in other
        # filters while its being constructed unless you garbage collect.
        GC.start

        el = Nokogiri::XML::Element.new(name, @document)
        Hash[*attributes].each_pair{|k, v| el[k] = v}
        @context = @context.add_child(el)
      end

      def end_element(name) #:nodoc:
        super
        raise "Unmatched closing element. Got '#{name}' but expected '#{@context.name}'" \
          unless name == @context.name
        @context = @context.parent
      end

      def characters(string) #:nodoc:
        super
        @context.add_child(Nokogiri::XML::Text.new(string, @document))
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
