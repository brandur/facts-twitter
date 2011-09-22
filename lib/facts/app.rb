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

      def conf_check(*confs)
        confs.each do |conf|
          raise ConfError.new(conf) unless App.conf.send(conf)
        end
      end

      def configure
        yield conf
      end
    end
  end

  class ConfError < StandardError
    attr_accessor :conf
    def initialize(conf)
      @conf = conf
    end
  end
end
