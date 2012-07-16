module Facts
  module Config
    extend self

    def http_api
      @http_api ||= env!("FACTS_HTTP_API")
    end

    def consumer_key
      @consumer_key ||= env!("CONSUMER_KEY")
    end

    def consumer_secret
      @consumer_secret ||= env!("CONSUMER_SECRET")
    end

    def dry_run?
      @dry_run ||= env("DRY_RUN") || false
    end

    def oauth_token
      @oauth_token ||= env!("OAUTH_TOKEN")
    end

    def oauth_token_secret
      @oauth_token_secret ||= env!("OAUTH_TOKEN_SECRET")
    end

    private

    def env(k)
      ENV[k] unless ENV[k] == nil
    end

    def env!(k)
      env(k) || raise("missing_environment=#{k}")
    end

  end
end
