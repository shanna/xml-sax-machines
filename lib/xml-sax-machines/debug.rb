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
        end_element
        end_element_namespace
        error
        start_document
        start_element
        start_element_namespace
        warning
        xmldecl
      }.each do |method|
        define_method(method.to_sym) do |*args|
          warn "#{method}: #{args.inspect}"
          super(*args)
        end
      end

    end # Debug
  end # SAX
end # XML
