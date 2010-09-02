require File.dirname(__FILE__) + '/../spec_helper'

describe AppConfig do
  before(:each) do
    @app_config = AppConfig.new
  end

  it "should be valid" do
    @app_config.should be_valid
  end
end
