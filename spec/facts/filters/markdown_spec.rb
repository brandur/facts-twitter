require 'spec_helper'

describe Facts::Filters::Markdown do
  before do
    @filter = Facts::Filters::Markdown.new
  end

  it "should replace Markdown links with just the link target" do
    @filter.filter("A link to [example.com](http://example.com).").should == "A link to http://example.com."
  end
end
