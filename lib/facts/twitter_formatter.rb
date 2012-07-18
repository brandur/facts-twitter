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
      content = content[0...max_content_length-1] + '…' if content.length > max_content_length

      # Append a link back to the fact's category. No matter how long this 
      # link turns out to be, Twitter will shorten it to a 20 character t.co.
      content += " #{Config.web}/#{category.slug}"

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

    # Apply filters to optimally format content for display on Twitter.
    def filter(str)
      FILTERS.each do |f|
        str = f.filter(str)
      end
      str
    end

    # Maximum content length before a URL, this is 140 (maximum length of a 
    # Twitter message) minus 21 (space plus 20 characters for a t.co URL) or 
    # 22 with the https protocol
    def max_content_length
      @@max_content_length ||= Config.web =~ /^https/ ? 118 : 119
    end
  end
end
