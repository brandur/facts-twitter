module Facts
  class Main
    def run
      # Ask the configured Facts installation for a random fact
      uri = URI.parse("#{App.conf.facts_uri}/facts/daily.json")
      req = Net::HTTP::Get.new(uri.path)
      rsp = Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(req)
      end

      # Decode the response to usable fact and category structs for easy 
      # digestion by the rest of the program
      facts = MultiJson.decode(rsp.body)
      fact, category = decode(facts.first)

      # Assemble a message that can be nicely displayed on Twitter
      content = TwitterFormatter.new.format(fact, category)
      puts content

      # Send the assembled message to Twitter as a status update
      Twitter.update(content) unless App.conf.dry_run
    end

    private

    def decode(fact_hash)
      fact_hash     = fact_hash['fact']
      category_hash = fact_hash['category']['category']
      fact     = Struct::Fact.new(fact_hash['content'])
      category = Struct::Category.new(category_hash['name'], category_hash['slug'])
      return fact, category
    end
  end

  private

  Struct.new('Fact', :content)
  Struct.new('Category', :name, :slug)
end
