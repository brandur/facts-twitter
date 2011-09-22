module Facts
  class Setup
    def run
      App.conf_check :consumer_key, :consumer_secret

      request_token = consumer.get_request_token
      puts "go to: #{request_token.authorize_url}"
      puts "get your OAuth PIN and enter it here:"
      pin = gets.chomp

      access_token = request_token.get_access_token :pin => pin
      puts "add your OAuth token to conf: #{access_token.token}"
      puts "add your OAuth secret to conf: #{access_token.secret}"
      exit(0)
    end

    private

    def consumer
      @consumer ||= OAuth::Consumer.new(App.conf.consumer_key, App.conf.consumer_secret, 
        :site => 'https://api.twitter.com')
    end
  end
end
