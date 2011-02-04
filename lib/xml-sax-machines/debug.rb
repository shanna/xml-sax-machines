module XML
  module SAX

    # SAX Debug filter.
    #
    # Warn all SAX event methods before calling the next filter in the chain. Handy as it can be placed anywhere in a
    # pipeline to see what events are being passed to the next filter.
    #
    # ==== See
    # * XML::SAX::Filter
    #
    class Debug < Filter

      %w{
        cdata_block
        characters
        comment
        end_document
        end_element_namespace
        error
        start_document
        warning
        xmldecl
      }.each do |method|
        define_method(method.to_sym) do |*args|
          warn "#{method}: #{args.inspect}"
          super(*args)
        end
      end

      def start_element_namespace name, attributes = [], prefix = nil, uri = nil, ns = []
        atts = attributes.map{|attribute| [[attribute.prefix, attribute.localname].compact.join(':'), attribute.value]}
        warn "start_element_namespace: [#{name.inspect}, #{atts.inspect}, #{prefix.inspect}, #{uri.inspect}, #{ns.inspect}]"
        super
      end

    end # Debug
  end # SAX
end # XML
