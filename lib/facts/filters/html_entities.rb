require 'htmlentities'

module Facts
  module Filters
    class HtmlEntities
      def filter(str)
        HTMLEntities.new.decode(str)
      end
    end
  end
end
