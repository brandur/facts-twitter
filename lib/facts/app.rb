module Facts
  class App
    class Conf
      attr_accessor :facts_uri
      attr_accessor :consumer_key, :consumer_secret
      attr_accessor :oauth_token, :oauth_token_secret
      attr_accessor :dry_run

      def initialize
        @dry_run = false
      end
    end

    class << self
      def conf
        @conf ||= Conf.new
      end

      def configure
        yield conf
      end
    end
  end
end
