require 'spec_helper'

describe Facts::Filters::Markdown do
  before do
    @filter = Facts::Filters::Markdown.new
  end

  it "should replace links with just the link target" do
    @filter.filter("A link to [example.com](http://example.com).").should == "A link to http://example.com."
  end

  it "should remove emphasis" do
    @filter.filter("an *emphasized* word").should == "an emphasized word"
    @filter.filter("an _emphasized_ word").should == "an emphasized word"
  end

  it "should remove strong emphasis" do
    @filter.filter("a **strongly emphasized** word").should == "a strongly emphasized word"
    @filter.filter("a __strongly emphasized__ word").should == "a strongly emphasized word"
  end

  it "should remove any HTML" do
    @filter.filter(<<-eos).should == "This is a paragraph with a nested tag."
      <p>
        This is a paragraph with a <strong>nested tag</strong>.
      </p>
    eos
  end
end
