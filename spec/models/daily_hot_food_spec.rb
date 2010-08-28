require File.dirname(__FILE__) + '/../spec_helper'

describe DailyHotFood do
  before(:each) do
    @daily_hot_food = DailyHotFood.new
  end

  it "should be valid" do
    @daily_hot_food.should be_valid
  end
end
