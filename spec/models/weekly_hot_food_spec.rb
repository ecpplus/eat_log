require File.dirname(__FILE__) + '/../spec_helper'

describe WeeklyHotFood do
  before(:each) do
    @weekly_hot_food = WeeklyHotFood.new
  end

  it "should be valid" do
    @weekly_hot_food.should be_valid
  end
end
