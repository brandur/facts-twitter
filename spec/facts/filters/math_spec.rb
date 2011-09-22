require 'spec_helper'

describe Facts::Filters::Math do
  before do
    @filter = Facts::Filters::Math.new
  end

  it "should replace old <math> tags with inline TeX" do
    @filter.filter("The speed of light is called <math>c</math>. Energy relates to mass as <math>E = mc^2</math>.").should == "The speed of light is called \\( c \\). Energy relates to mass as \\( E = mc^2 \\)."
  end
end
