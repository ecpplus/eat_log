require File.dirname(__FILE__) + '/../spec_helper'

describe UserFood do
  before(:each) do
    @user_food = UserFood.new
  end

  it "should be valid" do
    @user_food.should be_valid
  end
end
