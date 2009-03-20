module XML
  module SAX

    # Build a Nokogiri::XML::Document fragments that match an XPath.
    #
    # Stream large (or small) record based XML documents building each matching XPath into a document fragment making
    # futher manipulation of each record easier.
    #
    # ==== Notes
    # * In order to save memory well balanced elements that do not match any XPath are unlinked. This means you *cannot*
    #   match records by position in relation to siblings.
    # * Because we are parsing a SAX stream there is no read ahead. You *cannot* match records by any children the
    #   element may have once further events are pushed.
    # * You can match by attributes of an element.
    #
    # ==== Example
    #
    #   builder =  XML::SAX::FragmentBuilder.new(nil, {
    #     '//record' => lambda{|record| puts el.to_s} # Process each matched record element.
    #   })
    #   parser  =  Nokogiri::XML::SAX::PushParser.new(builder)
    #   parser  << %q{
    #     <root>
    #       <record id="1">record one</record>
    #       <record id="2">record two</record>
    #     </root>
    #   }
    #   #=> <record id="1">record one</record>
    #   #=> <record id="2">record two</record>
    #   parser.finish
    #
    # ==== See
    # * XML::SAX::Builder
    # * XML::SAX::Filter
    #
    # --
    # TODO:
    # * Namespaces.
    class FragmentBuilder < Builder
      private :document # Would return an empty/partial document you really shouldn't mess with.

      # ==== Parameters
      # handler<Nokogiri::XML::SAX::Document>::
      #   Optional next <tt>XML::SAX::Filter</tt> or <tt>Nokogiri::XML::SAX::Document<tt>(final) in the chain.
      #   By default a <tt>Nokogiri::XML::SAX::Document</tt> will be used making the chain final.
      #
      # options<Hash>::
      #   {xpath<String> => &block<Proc>} pairs. The first element passed to the block will be the matching
      #   Nokogiri::XML::Node. Keep in mind the node will be unlinked after your block returns.
      def initialize(options = {})
        super()
        @find   = options
        @found  = {}
        @buffer = 0
      end

      def start_element(name, attributes = []) #:nodoc:
        super
        @find.each_pair do |xpath, block|
          if match = @document.at(xpath)
            unless @found[match.path]
              @buffer += 1
              @found[match.path] = block
            end
          end
        end
      end

      def end_element(name) #:nodoc:
        path = @context.path
        if @buffer > 0 && block = @found.delete(path)
          @buffer -= 1
          block.call(@context)
        end
        super

        if @buffer == 0 && !(path == '/')
          @document.at(path).unlink

          # Unlinked children are not garbage collected till the document they were created in is (I think).
          # This hack job halves memory usage but it still grows too fast for my liking :(
          @document = @document.dup
          @context  = @document.at(@context.path) rescue nil
        end
      end

      def characters(string) # :nodoc:
        @buffer > 0 ? super : (filter && filter.characters(string))
      end

      def comment(string) # :nodoc:
        @buffer > 0 ? super : (filter && filter.comment(string))
      end

      def cdata_block(string) # :nodoc:
        @buffer > 0 ? super : (filter && filter.cdata_block(string))
      end

    end # FragmentBuilder
  end # SAX
end # XML
