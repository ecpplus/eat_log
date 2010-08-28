require File.dirname(__FILE__) + '/../spec_helper'

describe CronDaemon do
  before(:each) do
    @cron_daemon = CronDaemon.new
  end

  it "should be valid" do
    @cron_daemon.should be_valid
  end
end
