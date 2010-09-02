require File.dirname(__FILE__) + '/../spec_helper'

describe RequestToken do
  before(:each) do
    @request_token = RequestToken.new
  end

  it "should be valid" do
    @request_token.should be_valid
  end
end
