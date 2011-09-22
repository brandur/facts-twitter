module Facts
  module Filters
    # Provides some basic processing for mathematical expressions found in a 
    # fact.
    class Math
      def filter(str)
        # Remove deprecated math tags, and replace with inline TeX
        str = str.gsub(%r{<math>(.*?)</math>}, '\( \1 \)')

        str
      end
    end
  end
end
