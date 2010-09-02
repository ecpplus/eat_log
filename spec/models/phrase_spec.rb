require File.dirname(__FILE__) + '/../spec_helper'

describe Phrase do
  before(:each) do
    @phrase = Phrase.new
  end

  it "should be valid" do
    @phrase.should be_valid
  end
end
