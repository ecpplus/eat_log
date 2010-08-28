require File.dirname(__FILE__) + '/../spec_helper'

describe UserHotFood do
  before(:each) do
    @user_hot_food = UserHotFood.new
  end

  it "should be valid" do
    @user_hot_food.should be_valid
  end
end
