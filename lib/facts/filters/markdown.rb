module Facts
  module Filters
    # A pseudo-Markdown parser that cleans up desired Markdown entities for 
    # clean display on Twitter.
    class Markdown
      def filter(str)
        # Replace external links with just the link text (processes both
        # internal and external links)
        str = str.gsub(/\[(.*?)\]\((.*?)\)/, '\1')

        # Remove emphasis and strong emphasis -- it doesn't look very good on 
        # Twitter and takes up previous character space
        str = str.gsub(/\*\*(.*?)\*\*/, '\1')
        str = str.gsub(/__(.*?)__/, '\1')
        str = str.gsub(/\*(.*?)\*/, '\1')
        str = str.gsub(/_(.*?)_/, '\1')

        # Lastly, strip all HTML tags (which are allowed in Markdown)
        str.gsub(/<\/?[^>]*>/, '').strip
      end
    end
  end
end
