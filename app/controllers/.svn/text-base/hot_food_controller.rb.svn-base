class HotFoodController < ApplicationController
  def index
    @daily_hot_foods  = DailyHotFood.find(:all)
    @weekly_hot_foods = WeeklyHotFood.find(:all)
  end
end
