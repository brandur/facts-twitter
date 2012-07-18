# encoding: utf-8
require 'spec_helper'

describe Facts::TwitterFormatter do
  before do
    @formatter = Facts::TwitterFormatter.new
  end

  it "should match basic Twitter message format" do
    fact = mockb('fact') { |fact|
      fact.should_receive('content').and_return('Short fact content.')
    }
    category = mockb('category') { |category|
      category.should_receive('name').and_return('Tall Buildings')
      category.should_receive('slug').and_return('tall-buildings')
    }
    Facts::Config.should_receive(:web).at_least(:once).
      and_return('https://my-facts.example.com')

    formatted = @formatter.format(fact, category)
    formatted.should match(/^Tall Buildings:/)
    formatted.should include('Short fact content.')
    formatted.should match(%r{https://my-facts.example.com/tall-buildings$})
  end

  it "should truncate long content" do
    fact = mockb('fact') { |fact|
      fact.should_receive('content').and_return(<<-eos)
Some fact content with a more significant amount of content. The Ship of 
Theseus is a paradox that raises the question of whether an object which has 
all its component parts replaced remains fundamentally the same object. There 
is no way that this will fit in a Twitter message.
      eos
    }
    category = mockb('category') { |category|
      category.should_receive('name').and_return('Ship of Theseus')
      category.should_receive('slug').and_return('ship-of-theseus')
    }
    Facts::Config.should_receive(:web).at_least(:once).
      and_return('https://my-facts.example.com')

    formatted = @formatter.format(fact, category)

    # Should include at least the first part of the content
    formatted.should match(/^Ship of Theseus: Some fact content with a more/)

    # Should include an ellipsis
    formatted.should include('…') 

    # After replacing the long URL with a t.co (or a short 20 character 
    # equivalent), the message length should be exactly 140 characters
    post_submit = formatted.gsub(%r{https://my-facts.example.com/ship-of-theseus}, 'x' * 21)
    post_submit.length.should == 140
  end
end
