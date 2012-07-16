# encoding: utf-8

module Facts
  class TwitterFormatter
    # Given a fact and its parent category, assemble a message including as 
    # much data as possible that can be nicely sent to Twitter (i.e. in total 
    # the message can't exceed 140 characters).
    def format(fact, category)
      content = "#{category.name}: #{fact.content}"
      content = filter(content)

      # Constrain content to a length acceptable by Twitter
      content = content[0...MAX_CONTENT_LENGTH-1] + '…' if content.length > MAX_CONTENT_LENGTH

      # Append a link back to the fact's category. No matter how long this 
      # link turns out to be, Twitter will shorten it to a 20 character t.co.
      content += " #{Config.http_api}/#{category.slug}"

      content
    end

    private

    # List of filters to apply to a fact's content. Applied in order.
    FILTERS = [
      Filters::HtmlEntities.new, 
      Filters::Math.new, 
      # Keep Markdown last, as it will perform the most extensive filtering
      Filters::Markdown.new, 
    ].freeze

    # Maximum content length before a URL, this is 140 (maximum length of a 
    # Twitter message) minus 21 (space plus 20 characters for a t.co URL)
    MAX_CONTENT_LENGTH = 119

    # Apply filters to optimally format content for display on Twitter.
    def filter(str)
      FILTERS.each do |f|
        str = f.filter(str)
      end
      str  
    end
  end
end
