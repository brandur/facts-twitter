module Facts
  class Main
    def run
      Slides.log :run, core_hours_only: Config.core_hours_only?,
        outside_core_hours: outside_core_hours?, dry_run: Config.dry_run? do
        # Only Tweet during core hours. Assumes UTC.
        run_without_logging if !Config.core_hours_only? || !outside_core_hours?
      end
    end

    private

    def api
      @api ||= Excon.new(Config.api, instrumentor: Facts::ExconInstrumentor.new)
    end

    def decode(fact_hash)
      category_hash = fact_hash['category']
      fact     = Struct::Fact.new(fact_hash['content'])
      category = Struct::Category.new(category_hash['name'], category_hash['slug'])
      return fact, category
    end

    def outside_core_hours?
      !(7..19).include?((Time.now.utc.hour-6) % 24)
    end

    def run_without_logging
      # Ask the configured Facts installation for a random fact
      response = api.get(path: "/facts/random", expects: 200)

      # Decode the response to usable fact and category structs for easy 
      # digestion by the rest of the program
      facts = MultiJson.decode(response.body)
      fact, category = decode(facts.first)

      # Assemble a message that can be nicely displayed on Twitter
      content = TwitterFormatter.new.format(fact, category)
      Slides.log :format, content: content

      # Send the assembled message to Twitter as a status update
      Slides.log :tweet do
        Twitter.update(content) unless Config.dry_run?
      end
    end
  end

  private

  Struct.new('Fact', :content)
  Struct.new('Category', :name, :slug)
end
