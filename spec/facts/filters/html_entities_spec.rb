# encoding: utf-8

require 'spec_helper'

describe Facts::Filters::HtmlEntities do
  before do
    @filter = Facts::Filters::HtmlEntities.new
  end

  it "should filter HTML entities to be readable on the command line" do
    @filter.filter("Ways to travel&mdash;train, plane, automobile").should == "Ways to travel—train, plane, automobile"
  end
end
