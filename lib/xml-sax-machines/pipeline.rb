module XML
  module SAX

    # Define a filter chain top to bottom.
    #
    #--
    # TODO:
    # * More enumerable methods so you can alter pipelines.
    class Pipeline < Filter
      def initialize(*filters)
        self.filter = filters.each_with_index{|f, i| f.filter = filters[i + 1]}.first
      end
    end # Pipeline

  end # SAX
end # XML
