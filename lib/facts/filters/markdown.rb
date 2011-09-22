module Facts
  module Filters
    # A pseudo-Markdown parser that cleans up desired Markdown entities for 
    # clean display on Twitter.
    class Markdown
      def filter(str)
        # Replace Markdown links with just the link target
        str = str.gsub(/\[(.*?)\]\((.*?)\)/, '\2')

        str
      end
    end
  end
end
