module Facts
  class Main
    def run
      # Ask the configured Facts installation for a random fact
      uri = URI.parse("#{Config.http_api}/facts/random")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == "https"
      req = Net::HTTP::Get.new(uri.path)
      rsp = http.request(req)

      # Decode the response to usable fact and category structs for easy 
      # digestion by the rest of the program
      facts = MultiJson.decode(rsp.body)
      fact, category = decode(facts.first)

      # Assemble a message that can be nicely displayed on Twitter
      content = TwitterFormatter.new.format(fact, category)
      puts content

      # Send the assembled message to Twitter as a status update
      Twitter.update(content) unless Config.dry_run?
    end

    private

    def decode(fact_hash)
      category_hash = fact_hash['category']
      fact     = Struct::Fact.new(fact_hash['content'])
      category = Struct::Category.new(category_hash['name'], category_hash['slug'])
      return fact, category
    end
  end

  private

  Struct.new('Fact', :content)
  Struct.new('Category', :name, :slug)
end
