require File.dirname(__FILE__) + '/../spec_helper'

describe AccessToken do
  before(:each) do
    @access_token = AccessToken.new
  end

  it "should be valid" do
    @access_token.should be_valid
  end
end
